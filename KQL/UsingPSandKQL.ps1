Connect-AzAccount 

$WorkspaceName = 'LogAnalytics2li'
$WorkspaceResourceGroupName = 'LogAnalytics'
$Workspace = Get-AzOperationalInsightsWorkspace -ResourceGroupName $WorkspaceResourceGroupName -Name $WorkspaceName

$Query = @"
workspace("$WorkspaceName").AzureActivity 
    | where TimeGenerated > ago(120d) 
    | where ResourceProviderValue =~ "MICROSOFT.COMPUTE" and OperationNameValue =~ "MICROSOFT.COMPUTE/VIRTUALMACHINES/WRITE" and ActivitySubstatusValue =~ "Created" 
    | extend ResourceName = iff(isnull(Resource), Properties_d.resource, Resource) 
    | project TimeGenerated, OperationNameValue, ActivityStatusValue,ActivitySubstatusValue,ResourceName,ResourceGroup,Caller,SubscriptionId
"@

$QueryResults = Invoke-AzOperationalInsightsQuery -Workspace $Workspace -Query $Query

$QueryResults.Results 