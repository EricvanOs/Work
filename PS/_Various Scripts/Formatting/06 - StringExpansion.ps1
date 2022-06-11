# string expansion
$url = 'https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers'
$subscriptionId = '111-22-333'
$resourceGroupName = 'MyResourceGroup'

$ExecutionContext.InvokeCommand.ExpandString($url)