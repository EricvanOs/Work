$azc = Connect-AzAccount
$SubscriptionId = (Get-AzSubscription -TenantId ($azc.Context.Tenant)).Id
Set-AzContext -SubscriptionId $subscriptionId

# unzip
$Path = 'C:\Work\PS\_CM\AZ'
Expand-Archive -Path $Path\WebTemplate.zip -DestinationPath $Path\Web


# create resource group
$ResourceGroupName = 'myresourcegroup8877'
New-AzResourceGroup  -Name $ResourceGroupName -Location westeurope

# deploy template 
$templateFile = "$Path\Web\webtemplate.json"
$parameterFile="$Path\Web\Webtemplateparameters.json"

New-AzResourceGroupDeployment `
  -Name devenvironment `
  -ResourceGroupName $ResourceGroupName `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parameterFile



# cleanup
Get-AzResourceGroup -Name $ResourceGroupName | Remove-AzResourceGroup -Force
# see functions Invoke-Async.ps1 or invoke-command ..... -AsJob
Get-ChildItem -path $path  -Directory | Where-Object{$_.name -eq 'Web'}   | Remove-Item -Recurse -Force 




