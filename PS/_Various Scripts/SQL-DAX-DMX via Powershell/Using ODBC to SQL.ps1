$connectionstring = 'DRIVER={SQL Server};Server=echo;Database=AdventureWorks;Trusted_Connection=yes;'
$query = $query = @"
select top(10) * from person.address
"@

$connection = New-Object System.Data.Odbc.OdbcConnection
$connection.ConnectionString = $connectionstring
$connection.open()
$cmd = New-object System.Data.Odbc.OdbcCommand($query,$connection)
$dataset = New-Object system.Data.DataSet
$adapter = New-Object system.Data.odbc.odbcDataAdapter($cmd)
$adapter.fill($dataset) | out-null
$dataTable = $dataset.Tables[0]
$connection.close()
$adapter.Dispose()


$dataTable