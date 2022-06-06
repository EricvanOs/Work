Open-HeliosVault

$vault = 'ScriptingVault'
# Read secrets from vault 
$tenantId = (Get-Secret -Name TenantID -Vault $vault -AsPlainText) # Paste your own tenant ID here
$appId = (Get-Secret -Name MicrosoftDefenderForEndpoint-ApplicationID -Vault $vault -AsPlainText) # Paste your own app ID here
$appSecret = (Get-Secret -Name MicrosoftDefenderForEndpoint-Secret -Vault $vault -AsPlainText) # Paste your own app secret here

Close-HeliosVault


$resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
$oAuthUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
$body = [Ordered] @{
    resource = $resourceAppIdUri
    client_id = $appId
    client_secret = $appSecret
    grant_type = 'client_credentials'
}
$response = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $body -ErrorAction Stop
$aadToken = $response.access_token



# send a KQL query to endpoint
$query = 'DeviceInfo | limit 5' # Paste your own query here

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
want to send the following query, use a here-string
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

