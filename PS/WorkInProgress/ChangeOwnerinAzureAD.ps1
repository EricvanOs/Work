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



