$connectionString = 'Provider=MSOLAP;Data Source=selene;Initial Catalog=Contoso;'
$query = @'
EVALUATE SUMMARIZECOLUMNS('DimProduct'[BrandName], "Sales", [Sales])
'@
 
$connection = New-Object -TypeName System.Data.OleDb.OleDbConnection

$connection.ConnectionString = $connectionString
$command = $connection.CreateCommand()
$command.CommandText = $query
$adapter = New-Object -TypeName System.Data.OleDb.OleDbDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet 
$adapter.Fill($dataset) | Out-Null

$dataset.Tables[0] 
   
$connection.Close()