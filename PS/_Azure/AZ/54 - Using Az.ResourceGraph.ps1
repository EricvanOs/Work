
Search-AzGraph -Query "resources | summarize count () by subscriptionId" 

Search-AzGraph -Query "resources | project name, location, type | where type =~ 'Microsoft.Compute/virtualMachines' | order by name desc"

Search-AzGraph -Query "resources | where type =~ 'Microsoft.Compute/virtualMachines' | project name, properties.storageProfile.osDisk.osType | top 3 by name desc"



$query = @'
resources
	| where type == "microsoft.compute/virtualmachines"
	| project  computerNameOverride = tostring(properties.extended.instanceView.computerName), computerName = properties.osProfile.computerName
'@
Search-AzGraph -Query $query


$query = @'
resources 
	| where type =~ 'Microsoft.Network/publicIPAddresses' 
	| where properties.ipConfiguration =~ '' 
	| project name, resourceGroup, subscriptionId, location, tags, id
'@
Search-AzGraph -Query $query

$computer='ion2he'
$query = @"
resources
	| where type =~ 'Microsoft.Compute/virtualMachines'
	| where properties.osProfile.computerName =~ '$computer' or properties.extended.instanceView.computerName =~ '$computer'
	| join (ResourceContainers | where type=='microsoft.resources/subscriptions' | project SubName=name, subscriptionId) on subscriptionId
    | project VMName = name, CompName = properties.osProfile.computerName, OSType =  properties.storageProfile.osDisk.osType, RGName = resourceGroup, SubName, SubID = subscriptionId
"@
Search-AzGraph -Query $query

$query = @'
resources 
	| where type =~ 'Microsoft.Compute/virtualMachines' 
	| limit 1
'@
Search-AzGraph -Query $query 

$query = @'
resources
	| where type=~ 'microsoft.compute/virtualmachinescalesets'
	| where name contains '2he'
	| project subscriptionId, name, location, resourceGroup, Capacity = toint(sku.capacity), Tier = sku.name
	| order by Capacity desc
'@
Search-AzGraph -Query $query

$query = @'
resources
	| summarize resourceCount=count() by subscriptionId
	| join (ResourceContainers | where type=='microsoft.resources/subscriptions' | project SubName=name, subscriptionId) on subscriptionId
	| project-away subscriptionId, subscriptionId1
'@
Search-AzGraph -Query $query