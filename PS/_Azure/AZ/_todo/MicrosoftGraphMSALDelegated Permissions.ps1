
# zie MicrosoftGraphMSALDelegated Permissions
# 
# Install-Module -name MSAL.PS -Force -AcceptLicense
# Install-Module -name JWTDetails

Import-Module MSAL.PS

$clientID = "3c9176b8-0c77-4c12-b2c2-b446a77bc2ac"
$tenantID = "c395f110-ab2e-44ab-b096-7000e2511b32"

$myAccessToken = Get-MsalToken -DeviceCode -ClientId $clientID -TenantId $tenantID -RedirectUri "https://localhost" 

Import-Module JWTDetails
$myAccessToken.AccessToken | Get-JWTDetails



$myAuthMethods = (
Invoke-RestMethod -Headers @{Authorization = "Bearer $($myAccessToken.AccessToken)" } -Uri "https://graph.microsoft.com/beta/me/authentication/methods"  -Method Get
)
$myAuthMethods