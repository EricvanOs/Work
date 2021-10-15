# ResourceGroup deployment via template

# unzip
$Path = 'C:\Work\PS\_CM\AZ'
Expand-Archive -Path $Path\ResourceGroupTemplate.zip -DestinationPath $Path\RG


New-AzResourceGroupDeployment  -TemplateFile "$Path\RG\Template.json" -TemplateParameterFile "$Path\RG\Parameters.json"


get-command *template*




#cleanup
get-childitem -Path "$Path\RG" -Recurse | Remove-Item 
Get-ChildItem -Path $Path -Directory | Where-Object{$_.name -eq 'RG'} | Remove-Item 