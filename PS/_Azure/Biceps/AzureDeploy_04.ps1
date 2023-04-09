Connect-AzAccount

# Get subscriptionId
$SubscriptionId = (Get-AzContext | Where-Object{$_.Name -like "*MSDN*"}).Subscription.id

# set correct subscription you want to work with
Select-AzSubscription -SubscriptionId $SubscriptionId


# Create resource group
New-AzResourceGroup `
  -Name myResourceGroup `
  -Location "Central US"

# Deploy Bicep file

$bicepFile = "C:\Work\Azure\Biceps\AzureDeploy_04.bicep"
New-AzResourceGroupDeployment `
  -Name firstbicep `
  -ResourceGroupName myResourceGroup `
  -TemplateFile $bicepFile


# controle via portal

# cleanup

Remove-AzResourceGroup -Name myResourceGroup -Force

#  https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-tutorial-create-first-bicep?tabs=azure-powershell