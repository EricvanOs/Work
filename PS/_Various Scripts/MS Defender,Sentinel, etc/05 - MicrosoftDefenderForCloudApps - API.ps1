Open-HeliosVault
$vault = 'ScriptingVault'
# Read secrets from vault 
$tenantId = (Get-Secret -Name TenantID -Vault $vault -AsPlainText) 
$ApplicationId = (Get-Secret -Name MicrosoftDefenderForCloudApps-ApplicationID -Vault $vault -AsPlainText) 
$ApplicationSecret = (Get-Secret -Name MicrosoftDefenderForCloudApps-Secret -Vault $vault -AsPlainText) 
Close-HeliosVault

$resourceAppIdUri = 'https://xhelios.eu2.portal.cloudappsecurity.com'
$oAuthUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
$body = [Ordered] @{
    #resource = $resourceAppIdUri
    client_id = $ApplicationId
    client_secret = $ApplicationSecret
    grant_type = 'client_credentials'
}
$response = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $body -ErrorAction Stop
$aadToken = $response.access_token

# let's have a look at the access token
import-module JWTDetails
$aadToken | Get-JWTDetails


https://c395f110-ab2e-44ab-b096-7000e2511b32.eu2.portal.cloudappsecurity.com

https://login.microsoftonline.com/c395f110-ab2e-44ab-b096-7000e2511b32/oauth2/v2.0/token