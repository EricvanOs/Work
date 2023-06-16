# connect and set correct context
Set-AzContext -SubscriptionId (Get-AzSubscription -TenantId ((Connect-AzAccount).Context.Tenant)).Id

$ResourceGroupName = 'myResourceGroup77788'
$location = 'westeurope'
$StorageAccountName = 'mystorageaccount77788' 

$storage = @{
    ResourceGroupName = $ResourceGroupName
    Name = $StorageAccountName
    Location = $location
}

# create resourcegroup if needed
if ($null -eq (Get-AzResourceGroup  | Where-Object{$_.ResourceGroupName -eq $ResourceGroupName})) { New-AzResourceGroup -name $ResourceGroupName -Location westeurope }  

# create storage account
$storageAccount = New-AzStorageAccount @storage -SkuName Standard_LRS  -AllowBlobPublicAccess:$false

$ctx = $storageAccount.Context

# Blobs are always uploaded into a container. You can organize groups of blobs the way you organize your files on your computer in folders.

$containerName = "quickstartblobs"
New-AzStorageContainer -Name $containerName -Context $ctx # -Permission blob needed if AllowBlobPublicAccess:$true


# copy storage2he-polybase-customers.csv --> the just created storageaccount-container
$sourceStorageAccountContext = (Get-AzStorageAccount -ResourceGroupName storage -Name storage2he).Context
$sourcecontainername = 'polybase'
$srcblobname = 'Customers.csv'
$destinationStorageAccountContext = $ctx
$destcontainername = $containerName
$destblobname = $srcblobname

Copy-AzStorageBlob -SrcContainer $sourcecontainername -SrcBlob $srcblobname -DestContainer $destcontainername -DestBlob $destblobname  -Context $sourceStorageAccountContext -DestContext $destinationStorageAccountContext


# You can use the Set-AzStorageAccount cmdlet to modify an Azure Storage account.

Set-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName -Type "Standard_RAGRS"


#cleanup
Get-AzStorageBlob -Container $containerName -Context $ctx | Remove-AzStorageBlob
Get-AzStorageContainer -Context $ctx | Remove-AzStorageContainer
Get-AzStorageAccount -ResourceGroupName $ResourceGroupName | Remove-AzStorageAccount -Force
Get-AzResourceGroup  | Where-Object{$_.ResourceGroupName -eq $ResourceGroupName} | Remove-AzResourceGroup -Confirm:$false -Force


# to do
# https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-powershell
# https://learn.microsoft.com/en-us/answers/questions/954398/script-to-download-files-from-azure-storage-accoun

# https://baswijdenes.com/how-to-download-a-file-from-an-azure-storage-blob-powershell/
