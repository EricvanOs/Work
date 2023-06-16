# Device Login
Connect-AzAccount -UseDeviceAuthentication

$token = Get-AzAccessToken


$token.token | Get-JWTDetails

Disconnect-AzAccount

## 
Connect-AzAccount -AccessToken $token.Token -AccountId 'ericvanos@xhelios.onmicrosoft.com'
