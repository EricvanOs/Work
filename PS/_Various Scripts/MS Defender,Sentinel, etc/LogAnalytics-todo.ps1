#The resource URI
$resource = "https://westus2.api.loganalytics.io"
#Your Client ID and Client Secret obtained when registering your WebApp
$clientid = "yourAADAppClientID"
$clientSecret = "yourAADAppClientSecret"
#Your Reply URL configured when registering your WebApp
$redirectUri = "https://localhost"
#Scope
$scope = "Data.Read"
Add-Type -AssemblyName System.Web
#UrlEncode the ClientID and ClientSecret and URL's for special characters
$clientIDEncoded = [System.Web.HttpUtility]::UrlEncode($clientid)
$clientSecretEncoded = [System.Web.HttpUtility]::UrlEncode($clientSecret)
$resourceEncoded = [System.Web.HttpUtility]::UrlEncode($resource)
$scopeEncoded = [System.Web.HttpUtility]::UrlEncode($scope)
#Refresh Token Path
$refreshtokenpath = "C:\pathForYourRT\LogAnalyticsRefresh.token"

#Functions
Function Get-AuthCode {
    Add-Type -AssemblyName System.Windows.Forms
    $form = New-Object -TypeName System.Windows.Forms.Form -Property @{Width = 440; Height = 640 }
    $web = New-Object -TypeName System.Windows.Forms.WebBrowser -Property @{Width = 420; Height = 600; Url = ($url -f ($Scope -join "%20")) }
    $DocComp = {
        $Global:uri = $web.Url.AbsoluteUri        
        if ($Global:uri -match "error=[^&]*|code=[^&]*") { $form.Close() }
    }
    $web.ScriptErrorsSuppressed = $true
    $web.Add_DocumentCompleted($DocComp)
    $form.Controls.Add($web)
    $form.Add_Shown( { $form.Activate() })
    $form.ShowDialog() | Out-Null
    $queryOutput = [System.Web.HttpUtility]::ParseQueryString($web.Url.Query)
    $Global:output = @{ }
    foreach ($key in $queryOutput.Keys) {
        $output["$key"] = $queryOutput[$key]
    }
    $output
}

function Get-AzureAuthN ($resource) {
    # Get Permissions (if the first time, get an AuthCode and Get a Bearer and Refresh Token
    # Get AuthCode
    $url = "https://login.microsoftonline.com/common/oauth2/authorize?response_type=code&redirect_uri=$redirectUri&client_id=$clientID&resource=$resourceEncoded&scope=$scopeEncoded"
    Get-AuthCode
    # Extract Access token from the returned URI
    $regex = '(?<=code=)(.*)(?=&)'
    
    $authCode = ($uri | Select-String -pattern $regex).Matches[0].Value
    Write-Output "Received an authCode, $authCode"
    #get Access Token
    $body = "grant_type=authorization_code&redirect_uri=$redirectUri&client_id=$clientId&client_secret=$clientSecretEncoded&code=$authCode&resource=$resource"
    $Authorization = Invoke-RestMethod https://login.microsoftonline.com/common/oauth2/token `
        -Method Post -ContentType "application/x-www-form-urlencoded" `
        -Body $body `
        -ErrorAction STOP
    Write-Output $Authorization.access_token
    $Global:accesstoken = $Authorization.access_token
    $Global:refreshtoken = $Authorization.refresh_token 
    if ($refreshtoken) { $refreshtoken | Out-File "$($refreshtokenpath)" }

    if ($Authorization.token_type -eq "Bearer" ) {
        Write-Host "You've successfully authenticated to $($resource) with authorization for $($Authorization.scope)"           
    }
    else {
        Write-Host "Check the console for errors. Chances are you provided the incorrect clientID and clientSecret combination for the API Endpoint selected"
    }
}

function Get-NewTokens {
    # We have a previous refresh token. 
    # use it to get a new token
    $refreshtoken = Get-Content "$($refreshtokenpath)"
    # Refresh the token
    #get Access Token
    $body = "grant_type=refresh_token&refresh_token=$refreshtoken&redirect_uri=$redirectUri&client_id=$clientId&client_secret=$clientSecretEncoded"
    $Global:Authorization = Invoke-RestMethod https://login.microsoftonline.com/common/oauth2/token `
        -Method Post -ContentType "application/x-www-form-urlencoded" `
        -Body $body `
        -ErrorAction STOP
    $Global:accesstoken = $Authorization.access_token
    $Global:refreshtoken = $Authorization.refresh_token
    if ($refreshtoken) {
        $refreshtoken | Out-File "$($refreshtokenpath)"    
        Write-Host "Updated tokens" 
        $Authorization    
        $Global:headerParams = @{'Authorization' = "$($Authorization.token_type) $($Authorization.access_token)" }
    }
} 

$logAnalyticsWorkspace = "your Workspace ID"
$logAnalyticsBaseURI = "https://westus2.api.loganalytics.io/v1/workspaces"
# $logQuery = "AuditLogs | where SourceSystem == `"Azure AD`" | project Identity, TimeGenerated, ResultDescription | limit 50"
$logQuery = "AuditLogs | limit 50"

$logQueryBody = @{"query" = $logQuery } | convertTo-Json

# Get the Log Analytics Data
$result = invoke-RestMethod -method POST -uri "$($logAnalyticsBaseURI)/$($logAnalyticsWorkspace)/query" -Headers @{Authorization = "Bearer $($Global:accesstoken)"; "Content-Type" = "application/json" } -Body $logQueryBody

# Output Columns for CSV
$headerRow = $null
$headerRow = $result.tables.columns | Select-Object name
$columnsCount = $headerRow.Count
# Format the Report
$logData = @()
foreach ($row in $result.tables.rows) {
    $data = new-object PSObject
    for ($i = 0; $i -lt $columnsCount; $i++) {
        $data | add-member -membertype NoteProperty -name $headerRow[$i].name -value $row[$i]
    }
    $logData += $data
    $data = $null
}
# Export to CSV
$logData | export-csv C:\yourReportPath\logAnalytics.csv -NoTypeInformation

Connect-AzAccount
https://management.azure.com/subscriptions/940541f2-0f53-48e7-8046-f6530b423abc/resourcegroups/loganalytics/providers/Microsoft.OperationalInsights/workspaces/loganalytics2li/tables/AzureDiagnostics?api-version=2021-12-01-preview



$ApplicationId = '8770e2b9-1e44-429b-80c1-f16ba65f68cd'
$ApplicationSecret = '5vs8Q~0neWTeFU5edznvu24REgt8dU4k4dA.8cTK'

$scope = "Data.Read"


Open-HeliosVault
Set-Secret -Name LogAnalytics-Secret -Secret '5vs8Q~0neWTeFU5edznvu24REgt8dU4k4dA.8cTK'  -Vault 'ScriptingVault'


#$resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
$oAuthUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
$body = [Ordered] @{
    client_id = $ApplicationId
    client_secret = $ApplicationSecret
    grant_type = 'client_credentials'
    scope = $scope
}
$response = Invoke-RestMethod -Method GET -Uri $oAuthUri -Body $body -ErrorAction Stop
$aadToken = $response.access_token
