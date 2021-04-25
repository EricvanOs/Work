$connectionString = 'Provider=MSOLAP;Data Source=selene;Initial Catalog=Contoso;'
$query = @'
 SELECT NON EMPTY { [Measures].[Sales] } ON COLUMNS, 
 NON EMPTY { ([DimProduct].[BrandName].[BrandName].ALLMEMBERS ) } DIMENSION PROPERTIES MEMBER_CAPTION, MEMBER_UNIQUE_NAME ON ROWS 
 FROM [Model] CELL PROPERTIES VALUE, BACK_COLOR, FORE_COLOR, FORMATTED_VALUE, FORMAT_STRING, FONT_NAME, FONT_SIZE, FONT_FLAGS
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