$connectionString = 'Data Source=echo;Integrated Security=SSPI;Initial Catalog=AdventureWorks'
$query = @"
SELECT TOP 25  [ContactID],[FirstName],[LastName],[EmailAddress],[Phone]
FROM [AdventureWorks].[Person].[Contact]
"@

$connection = new-object system.data.SqlClient.SqlConnection($connectionString)
$dataset = new-object 'System.Data.DataSet'
$adapter = new-object 'System.Data.SqlClient.SqlDataAdapter' ($query, $connection)
$adapter.Fill($dataset) | Out-Null
$DataTable = $dataset.Tables[0]
$connection.Close()
$dataset.Dispose()

$DataTable