# string expansion
$url = 'https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers'
$subscriptionId = '111-22-333'
$resourceGroupName = 'MyResourceGroup'

$ExecutionContext.InvokeCommand.ExpandString($url)


# according to documentation the following syntax is normally used
# create here-string, should be single quoted as expansion should not happen
$url = @'
    https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents?api-version=2021-10-01
'@  

# create variables with same name as in the curly braces. Use Set-Variable for readability
Set-Variable subscriptionId -Value '11-22-333'
Set-Variable resourceGroupName  -Value 'loganalytics'
Set-Variable workspaceName  -Value 'loganalytics2li'


#expand the variable
$ExpandedUrl = $ExecutionContext.InvokeCommand.ExpandString(($url -replace '{','${'))
$ExpandedUrl

# You can reuse the url with different values of the variables
Set-Variable subscriptionId -Value '1234'
Set-Variable resourceGroupName  -Value 'loglog'
Set-Variable workspaceName  -Value '2li2li'

$ExpandedUrl = $ExecutionContext.InvokeCommand.ExpandString(($url -replace '{','${'))
$ExpandedUrl