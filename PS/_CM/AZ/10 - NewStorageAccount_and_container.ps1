# connect and set correct context
Set-AzContext -SubscriptionId (Get-AzSubscription -TenantId ((Connect-AzAccount).Context.Tenant)).Id


$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroup `
-Name "mystorageaccount" `
-SkuName Standard_LRS `
-Location $location `
$ctx = $storageAccount.Context

# Blobs are always uploaded into a container. You can organize groups of blobs the way you organize your files on your computer in folders.


$containerName = "quickstartblobs"
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob

# You can use the Set-AzStorageAccount cmdlet to modify an Azure Storage account.

Set-AzStorageAccount -ResourceGroupName "MyResourceGroup" -AccountName "mystorageaccount" -Type "Standard_RAGRS"






