$subscriptionid = (Get-Azsubscription).id


$readerActions = `
"Microsoft.DataMigration/services/*/read", `
"Microsoft.Network/networkInterfaces/ipConfigurations/read"

$writerActions = `
"Microsoft.DataMigration/services/*/write", `
"Microsoft.DataMigration/services/*/delete", `
"Microsoft.DataMigration/services/*/action"

$writerActions += $readerActions

# $subScopes = ,"/subscriptions/00000000-0000-0000-0000-000000000000/","/subscriptions/11111111-1111-1111-1111-111111111111/"
$subScopes = "/subscriptions/$subscriptionid/"

function New-DmsReaderRole() {
$aRole = [Microsoft.Azure.Commands.Resources.Models.Authorization.PSRoleDefinition]::new()
$aRole.Name = "Azure Database Migration Reader"
$aRole.Description = "Lets you perform read only actions on DMS service/project/tasks."
$aRole.IsCustom = $true
$aRole.Actions = $readerActions
$aRole.NotActions = @()
$aRole.AssignableScopes = $subScopes
#Create the role
New-AzRoleDefinition -Role $aRole 
}


function New-DmsContributorRole() {
$aRole = [Microsoft.Azure.Commands.Resources.Models.Authorization.PSRoleDefinition]::new()
$aRole.Name = "Azure Database Migration Contributor"
$aRole.Description = "Lets you perform CRUD actions on DMS service/project/tasks."
$aRole.IsCustom = $true
$aRole.Actions = $writerActions
$aRole.NotActions = @()
$aRole.AssignableScopes = $subScopes
#Create the role
New-AzRoleDefinition -Role $aRole 
}

function Update-DmsReaderRole() {
$aRole = Get-AzRoleDefinition "Azure Database Migration Reader"
$aRole.Actions = $readerActions
$aRole.NotActions = @()
Set-AzRoleDefinition -Role $aRole 
}

function Update-DmsConributorRole() {
$aRole = Get-AzRoleDefinition "Azure Database Migration Contributor"
$aRole.Actions = $writerActions
$aRole.NotActions = @()
Set-AzRoleDefinition -Role $aRole 
}

# invoke the following

New-DmsReaderRole
New-DmsContributorRole
Update-DmsReaderRole
Update-DmsConributorRole
