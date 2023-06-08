$azc = Connect-AzAccount
$SubscriptionId = (Get-AzSubscription -TenantId ($azc.Context.Tenant)).Id
Set-AzContext -SubscriptionId $subscriptionId

# unzip
$Path = 'C:\Work\PS\_Azure\AZ'
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


# cleanup -- Asynchronously
# https://learn.microsoft.com/en-us/powershell/azure/using-psjobs?view=azps-9.4.0


Start-Job -Name Cleanup -ScriptBlock{
  Get-AzResourceGroup -Name $using:ResourceGroupName | Remove-AzResourceGroup -Force -Confirm:$false
} 

Get-Job -Name Cleanup
Receive-Job -Name Cleanup


Get-ChildItem -path $path  -Directory | Where-Object{$_.name -eq 'Web'}   | Remove-Item -Recurse -Force 




