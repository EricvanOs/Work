Search-AzGraph -Query "summarize count () by subscriptionId" | Format-Table

Search-AzGraph -Query "project name, location, type|
 where type =~ 'Microsoft.Compute/virtualMachines' | order by name desc"

Search-AzGraph -Query "where type =~ 'Microsoft.Compute/virtualMachines' |
 project name, properties.storageProfile.osDisk.osType | top 3 by name desc"

Search-AzGraph -Query "where tags.Role=~'DC' | project name, tags"

$query = @"
Resources
| where type == "microsoft.compute/virtualmachines"
| project  computerNameOverride = tostring(properties.extended.instanceView.computerName), computerName = properties.osProfile.computerName
"@
Search-AzGraph -Query $query


$query = @"
Resources | 
where type =~ 'Microsoft.Network/publicIPAddresses' |
where properties.ipConfiguration =~ '' |
project name, resourceGroup, subscriptionId, location, tags, id
"@
Search-AzGraph -Query $query

$query = @"
Resources
	| where type =~ 'Microsoft.Compute/virtualMachines'
	| where properties.osProfile.computerName =~ 'hera2he' or properties.extended.instanceView.computerName =~ 'hera2he'
	| join (ResourceContainers | where type=='microsoft.resources/subscriptions' | project SubName=name, subscriptionId) on subscriptionId
    | project VMName = name, CompName = properties.osProfile.computerName, OSType =  properties.storageProfile.osDisk.osType, RGName = resourceGroup, SubName, SubID = subscriptionId
"@
Search-AzGraph -Query $query

# default Depth level = 2
$query = @"
Resources 
| where type =~ 'Microsoft.Compute/virtualMachines' 
| limit 1
"@
Search-AzGraph -Query $query | ConvertTo-Json -Depth 100

$query = @"
Resources
| where type=~ 'microsoft.compute/virtualmachinescalesets'
| where name contains 'contoso'
| project subscriptionId, name, location, resourceGroup, Capacity = toint(sku.capacity), Tier = sku.name
| order by Capacity desc
"@
Search-AzGraph -Query $query

$query = @"
Resources
| summarize resourceCount=count() by subscriptionId
| join (ResourceContainers | where type=='microsoft.resources/subscriptions' | project SubName=name, subscriptionId) on subscriptionId
| project-away subscriptionId, subscriptionId1
"@
Search-AzGraph -Query $query