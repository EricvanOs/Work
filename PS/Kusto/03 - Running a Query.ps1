$queryProvider = [Kusto.Data.Net.Client.KustoClientFactory]::CreateCslQueryProvider($kcsb)
$query = @'
StormEvents 
 | limit 5 
 | project StartTime,State,EventType
'@
# Write-Host "Executing query: '$query' with connection string: '$($kcsb.ToString())'"

#  Optional: set a client request ID and set a client request property (e.g. Server Timeout)
$crp = New-Object Kusto.Data.Common.ClientRequestProperties
$crp.ClientRequestId = "MyPowershellScript.ExecuteQuery." + [Guid]::NewGuid().ToString()
$crp.SetOption([Kusto.Data.Common.ClientRequestProperties]::OptionServerTimeout, [TimeSpan]::FromSeconds(30))

#   Execute the query
$reader = $queryProvider.ExecuteQuery($query, $crp)

# Do something with the result datatable, for example: print it formatted as a table, sorted by the 
# "StartTime" column, in descending order
$dataTable = [Kusto.Cloud.Platform.Data.ExtendedDataReader]::ToDataSet($reader).Tables[0]
$dataView = New-Object System.Data.DataView($dataTable)
$dataView | Sort-Object StartTime -Descending | Format-Table -AutoSize
