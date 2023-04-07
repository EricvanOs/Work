# https://learn.microsoft.com/it-it/graph/api/user-get?view=graph-rest-1.0&tabs=powershell

Import-Module -Name JWTDetails

Open-HeliosVault

$vault = 'ScriptingVault'
# Read secrets from vault 
$tenantId = (Get-Secret -Name TenantID -Vault $vault -AsPlainText) 
$ApplicationId = (Get-Secret -Name MSGraphUsers-ApplicationID -Vault $vault -AsPlainText) 
$ApplicationSecret = (Get-Secret -Name MSGraphUsers-Secret -Vault $vault -AsPlainText) 

Close-HeliosVault


$openid = Invoke-RestMethod  -uri "https://login.microsoftonline.com/$tenantId/v2.0/.well-known/openid-configuration" 
$token = $openid.token_endpoint


$Body = @{
    client_id = $ApplicationId      
    client_secret = $ApplicationSecret      
    redirect_uri = "https://localhost"
    grant_type = "client_credentials"
    scope = "https://graph.microsoft.com/.default" 
    tenant = $tenantId
}

# request access token
$request = Invoke-RestMethod -uri $token -Body $Body -Method Post

# what is in the access token ?
Get-JWTDetails $request.access_token 


$graph = "https://graph.microsoft.com/v1.0/users"

$api = Invoke-RestMethod -Headers @{Authorization = "Bearer $($request.access_token)"} -uri $graph -Method Get

$api.value | Select-Object  -Property *


# give "auto" consent to group

$graph = "https://graph.microsoft.com/v1.0/groups"

$api = Invoke-RestMethod -Headers @{Authorization = "Bearer $($request.access_token)"} -uri $graph -Method Get

$api.value




