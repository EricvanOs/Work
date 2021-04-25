$cred = Connect-AzAccount

# Set-AzContext $cred.subscriptionId

# Create resource group
New-AzResourceGroup `
  -Name myResourceGroup `
  -Location "Central US"

# Deploy Bicep file

$bicepFile = "C:\Work\Azure\Biceps\AzureDeploy.bicep"
New-AzResourceGroupDeployment `
  -Name firstbicep `
  -ResourceGroupName myResourceGroup `
  -TemplateFile $bicepFile


# controle via portal

# cleanup

Remove-AzResourceGroup -Name myResourceGroup -Force