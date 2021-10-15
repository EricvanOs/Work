# import with parameter , run Get-Module -list AzureAD ; PSEdition = Desk 
# run as if windowspowershell 

Import-Module AzureAD -UseWindowsPowerShell
connect-AzureAd

<#
AzureAD cmdlets require you to identify whether a role is already in use before you can assign it to a user. 
If no users have been assigned to a role, then it exists only as a template, and you need to enable
the role before you can add users to it. 
You can use the Get-AzureADDirectoryRole cmdlet to review the
roles that are enabled. Use the Get-AzureADDirectoryRoleTemplate cmdlet to review the roles that
aren't yet enabled.
The following example depicts how to enable the User Administrator role. When you enable the role, you
need to refer to the object ID of the template:
#>

$roleTemplate = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.displayName -eq 'User Administrator'}
Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId

<#
After you enable the role, you can add a role member to assign administrative permissions by using the
Add-AzureADDirectoryRoleMember cmdlet. The following example depicts how to add an account to
the User Administrator role. The -ObjectId parameter refers to the ObjectID of the role. The -RefObjectId
parameter refers to the ObjectID of the user account:
#>

$user = Get-AzureADUser -ObjectID AbbieP@adatum.com
$role = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq 'User Administrator'}
Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId $user.ObjectID