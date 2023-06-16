
# https://learn.microsoft.com/en-us/powershell/microsoftgraph/find-mg-graph-permission?view=graph-powershell-1.0

# list of all different permissions
Find-MgGraphPermission -PermissionType Any
Find-MgGraphPermission -PermissionType Application 
Find-MgGraphPermission  Application.Read 


# connect to graph
Connect-MgGraph -Scopes 'Application.Read.All'

# Consent Information for a specific Application
$MsGraphUsers = Get-MgApplication | Where-Object{$_.DisplayName -eq 'MSGraphUsers'}
Get-MgApplication -ApplicationId $MsGraphUsers.id  # ObjectId (NOT ApplicationID). A lot of info but no consent information

Get-AzADAppPermission -ObjectId $MsGraphUsers.id

# combining both result sets
Import-Module -Name JoinModule
$AllPermissions = Find-MgGraphPermission -PermissionType Application 
$Permissions = Get-AzADAppPermission -ObjectId $MsGraphUsers.id

$Permissions | InnerJoin $AllPermissions -On id -Equals id | Select-Object -Property Name,Type, PermissionType,Consent

