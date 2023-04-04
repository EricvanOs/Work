
#Invoke-sqlcmd Connection string parameters
$params = @{'server'='Echo';'Database'='tempdb'}
 
#function to retrieve disk information
Function Get-DisksSpace ([string]$Servername)
{
Get-WmiObject win32_logicaldisk -ComputerName $Servername -Filter "Drivetype=3" |`
select  SystemName,DeviceID,VolumeName,@{Label="Total SIze";Expression={$_.Size / 1gb -as [int] }},@{Label="Free Size";Expression={$_.freespace / 1gb -as [int] }}
}
 
#Variable to hold output as data-table
$dataTable = Get-DisksSpace hqdbsp18 |  Out-DataTable
#Define Connection string
$connectionString = "Data Source=echo; Integrated Security=True;Initial Catalog=tempdb;"
#Bulk copy object instantiation
$bulkCopy = new-object ("Data.SqlClient.SqlBulkCopy") $connectionString
#Define the destination table 
$bulkCopy.DestinationTableName = "DiskInformation"
#load the data into the target
$bulkCopy.WriteToServer($dataTable)
#Query the target table to see for output
Invoke-Sqlcmd @params -Query "SELECT  * FROM DiskInformation" | format-table -AutoSize