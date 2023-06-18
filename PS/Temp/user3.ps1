Connect-MgGraph

Get-MgUser -UserId 'AbbieP@in-li.eu' -ExpandProperty manager | Select-Object @{Name = 'Manager'; Expression = {$_.Manager.AdditionalProperties.displayName}}



# Set the properties to retrieve
$properties = @(
    'id',
    'DisplayName',
    'userprincipalname',
    'mail',
    'jobtitle',
    'department',
    'OfficeLocation',
    'MobilePhone',
    'BusinessPhones',
    'streetAddress',
    'City',
    'postalcode',
    'state',
    'Country',
    'AccountEnabled',
    'CreatedDateTime'
)

$select = $properties

Get-MgUser -Filter $filter -Property $properties | Select-Object $select


Get-MgUser -Filter $filter -Property $properties 


https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/get-mguser?view=graph-powershell-1.0


https://learn.microsoft.com/en-us/graph/aad-advanced-queries?tabs=powershell