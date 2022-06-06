Open-HeliosVault

$vault = 'ScriptingVault'
# Read secrets from vault 
$tenantId = (Get-Secret -Name TenantID -Vault $vault -AsPlainText) 
$ApplicationId = (Get-Secret -Name MicrosoftDefenderForEndpoint-ApplicationID -Vault $vault -AsPlainText) 
$ApplicationSecret = (Get-Secret -Name MicrosoftDefenderForEndpoint-Secret -Vault $vault -AsPlainText) 

Close-HeliosVault


$resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
$oAuthUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
$body = [Ordered] @{
    resource = $resourceAppIdUri
    client_id = $ApplicationId
    client_secret = $ApplicationSecret
    grant_type = 'client_credentials'
}
$response = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $body -ErrorAction Stop
$aadToken = $response.access_token


# https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/exposed-apis-list?view=o365-worldwide
# look at advanced hunting
# https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/run-advanced-query-sample-powershell?view=o365-worldwide

# send a KQL query to endpoint (use here-string)
$query = @'
    DeviceInfo | limit 5
'@   
$url = "https://api-eu.securitycenter.microsoft.com/api/advancedqueries/run"
$headers = @{ 
    'Content-Type' = 'application/json'
    Accept = 'application/json'
    Authorization = "Bearer $aadToken" 
}
$body = ConvertTo-Json -InputObject @{ 'Query' = $query }
$webResponse = Invoke-WebRequest -Method Post -Uri $url -Headers $headers -Body $body -ErrorAction Stop
$response =  $webResponse | ConvertFrom-Json
$response.Results.DeviceName


<#
want to send the following query, use a here-string (single quote - see $filter)
https://api-eu.securitycenter.windows.com/api/machines?$filter=healthStatus eq 'Active'
#>
$url = @'
    https://api-eu.securitycenter.microsoft.com/api/machines?$filter=healthStatus eq 'Active'
'@

$headers = @{ 
    'Content-Type' = 'application/json'
    Accept = 'application/json'
    Authorization = "Bearer $aadToken" 
}

$webResponse = Invoke-WebRequest -Method GET -Uri $url -Headers $headers -ErrorAction Stop
$response =  $webResponse | ConvertFrom-Json
$response.value.computerdnsname

