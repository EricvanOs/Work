#  Part 1 of 3
#  ------------
#  Packages location - This is an example to the location where you extract the Microsoft.Azure.Kusto.Tools.NETCore package.
#  https://www.nuget.org/packages/Microsoft.Azure.Kusto.Tools.NETCore/

dotnet add package Microsoft.Azure.Kusto.Tools --version 6.0.3

Find-Package -Name Microsoft.Azure.Kusto.Tools -Source nuget.org | Install-Package

#  Please make sure you load the types from a local directory and not from a remote share. --Use iSE
$packagesRoot = "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.Azure.Kusto.Tools.6.0.3\tools\net472" 

#  Part 2 of 3
#  ------------
#  Loading the Kusto.Client library and its dependencies
Get-ChildItem $packagesRoot\* | Unblock-File
[System.Reflection.Assembly]::LoadFrom("$packagesRoot\Kusto.Data.dll")

#  Part 3 of 3
#  ------------
#  Defining the connection to your cluster / database
$clusterUrl = "https://help.kusto.windows.net;Fed=True"
$databaseName = "Samples"

#   Option A: using AAD User Authentication
$kcsb = New-Object Kusto.Data.KustoConnectionStringBuilder ($clusterUrl, $databaseName)
 
#   Option B: using AAD application Authentication
#     $applicationId = "application ID goes here"
#     $applicationKey = "application key goes here"
#     $authority = "authority goes here"
#     $kcsb = $kcsb.WithAadApplicationKeyAuthentication($applicationId, $applicationKey, $authority)


<# nog uitzoeken
https://docs.microsoft.com/en-us/azure/data-explorer/kusto/api/connection-strings/kusto

cluster(https://ade.loganalytics.io/subscriptions/<subscription-id>/resourcegroups/<resource-group-name>/providers/microsoft.operationalinsights/workspaces/<workspace-name>)

https://ade.loganalytics.io/subscriptions/940541f2-0f53-48e7-8046-f6530b423abc/resourcegroups/loganalytics/providers/microsoft.operationalinsights/workspaces/loganalytics2li

#>