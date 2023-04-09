# connection
Connect-MgGraph  -Scopes "RoleManagement.Read.Directory", "Directory.Read.All", "RoleManagement.ReadWrite.Directory"

# search template to use
$roleTemplate = Get-MgDirectoryRoleTemplate | Where-Object {$_.displayName -eq 'User Administrator'}

$params = @{
	RoleTemplateId = $roleTemplate.id
}
New-MgDirectoryRole -BodyParameter $params  #will fail as role is already available in the directory

# add user to role
$user = Get-MgUser -UserId AbbieP@in-li.eu
$role = Get-MgDirectoryRole | Where-Object {$_.displayName -eq 'User Administrator'}

$DirObject = @{
    "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.id)"
    }

New-MgDirectoryRoleMemberByRef -DirectoryRoleId $role.id -BodyParameter $DirObject

# test if user is member of role
# entities of a role
Get-MgDirectoryRoleMember -DirectoryRoleId $role.Id
# compare with
$user

# remove user from role
Remove-MgDirectoryRoleMemberByRef -DirectoryRoleId $role.id -DirectoryObjectId $user.id

# verify
Get-MgDirectoryRoleMember -DirectoryRoleId $role.Id