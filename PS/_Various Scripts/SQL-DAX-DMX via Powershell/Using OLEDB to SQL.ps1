$connectionString = 'Provider=sqloledb;Data Source=eos;Initial Catalog=AdventureWorks;Integrated Security=SSPI'
$query = @'
select top(11) * from person.address
'@
 
$connection = New-Object -TypeName System.Data.OleDb.OleDbConnection
$connection.ConnectionString = $connectionString
$command = $connection.CreateCommand()
$command.CommandText = $query
$adapter = New-Object -TypeName System.Data.OleDb.OleDbDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet 
$adapter.Fill($dataset) | Out-Null
$DataTable = $dataset.Tables[0] 
$connection.Close()
$adapter.Dispose()


$DataTable