# Login Azure AD
$credential = Get-Credential

Import-Module AzureAD -SkipEditionCheck
Import-Module AzureAD -UseWindowsPowerShell
Connect-AzureAD 
Connect-AzureAD -Credential $credential


$refid = (get-azureaduser | Where-Object{$_.UserPrincipalName -eq 'ericvanos@xhelios.onmicrosoft.com'}).ObjectID
$objid = (get-azureaddevice | Where-Object{$_.displayname -eq 'mnemosyne'}).Objectid

# adding the new owner to the device where ObjectId is the object id from the device you want to change and RefObjecteID is the object id from the new user and owner.
Add-AzureADDeviceRegisteredOwner -ObjectId $objid -RefObjectId $refid

# remove the existing/old owner from the device where ObjectID is the object id from the device you want to change and OwnerId the object id from the existing/old user.
Remove-AzureADDeviceRegisteredOwner -ObjectId 9cfabe6a-xxxx-xxxx-xxxx-xxxxxxxxxxxx -OwnerId 2d2c5e37-xxxx-xxxx-xxxx-xxxxxxxxxxxx


<#
https://matrixpost.net/change-owner-for-azure-ad-joined-windows-10-devices/

https://docs.microsoft.com/en-us/troubleshoot/azure/active-directory/pending-devices

#>


Disconnect-MgGraph

Connect-MgGraph  -scopes  'User.ReadWrite.All','User.Read.All', 'Device.Read.All' 

$UserId = (get-MgUser | Where-Object{$_.UserPrincipalName -eq 'ericvanos@xhelios.onmicrosoft.com'}).Id

$ObjectId = (Get-MgDevice | Where-Object{$_.Displayname -eq 'mnemosyne'}).Id

Get-MgDevice | Format-List

# add new owner to device
$params = @{
	"@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$UserId"
}
New-MgDeviceRegisteredOwnerByRef -DeviceId $ObjectId -BodyParameter $params


New-MgDeviceRegisteredOwnerByRef -DeviceId $DeviceId -

-ObjectId $objid -RefObjectId $refid

################

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





Connect-MgGraph -AccessToken $request.access_token


$UserId = (get-MgUser | Where-Object{$_.UserPrincipalName -eq 'ericvanos@xhelios.onmicrosoft.com'}).Id

$ObjectId = (Get-MgDevice | Where-Object{$_.Displayname -eq 'mnemosyne'}).Id

Get-MgDevice | Format-List

# add new owner to device
$params = @{
	"@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$UserId"
}
New-MgDeviceRegisteredOwnerByRef -DeviceId $ObjectId -BodyParameter $params

