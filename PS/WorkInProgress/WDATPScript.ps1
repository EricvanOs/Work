$tenantId = 'c395f110-ab2e-44ab-b096-7000e2511b32' # Paste your own tenant ID here
$appId = 'bcbecf0b-f5c6-4722-a1e9-ace2078235f1' # Paste your own app ID here
$appSecret = 'kxWQU12WL7_yMyP2Pq6q4d-zINcw1~_YYV' # Paste your own app secret here

$resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
$oAuthUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
$body = [Ordered] @{
    resource = "$resourceAppIdUri"
    client_id = "$appId"
    client_secret = "$appSecret"
    grant_type = 'client_credentials'
}
$response = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $body -ErrorAction Stop
$aadToken = $response.access_token




$query = 'RegistryEvents | limit 10' # Paste your own query here

$url = "https://api-eu.securitycenter.microsoft.com/api/advancedqueries/run"
$headers = @{ 
    'Content-Type' = 'application/json'
    Accept = 'application/json'
    Authorization = "Bearer $aadToken" 
}
$body2 = ConvertTo-Json -InputObject @{ 'Query' = $query }
$webResponse = Invoke-WebRequest -Method Post -Uri $url -Headers $headers -Body $body2 -ErrorAction Stop
$response =  $webResponse | ConvertFrom-Json
$results = $response.Results
$schema = $response.Schema





https://api-eu.securitycenter.windows.com/api/machines?$filter=healthStatus eq 'Inactive'


$query = '' # RegistryEvents | limit 10' # Paste your own query here

$url = "https://api-eu.securitycenter.microsoft.com/api/machines?$filter=healthStatus eq 'Inactive'"
$headers = @{ 
    'Content-Type' = 'application/json'
    Accept = 'application/json'
    Authorization = "Bearer $aadToken" 
}
$body2 = ConvertTo-Json -InputObject @{  }
$webResponse = Invoke-WebRequest -Method GET -Uri $url -Headers $headers -ErrorAction Stop
$response =  $webResponse | ConvertFrom-Json
$results = $response.Results
$schema = $response.Schema