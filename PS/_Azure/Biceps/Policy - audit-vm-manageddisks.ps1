$PathBicepFile = 'C:\work\azure\Biceps\Policy - audit-vm-manageddisks.bicep'
$ResourceGroup = 'PolicyDeployment'

New-AzResourceGroup  -Name $ResourceGroup -Location 'westus'


# Deploy and wait
New-AzResourceGroupDeployment -Name PolicyManagedDisk -ResourceGroupName $ResourceGroup  -TemplateFile $PathBicepFile

# look if deployment of policy succeeded : policy -- scope MSDN Platforms/PolicyDeployment

# cleanup
Remove-AzResourceGroup -Name $ResourceGroup -Force
