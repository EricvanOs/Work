$ServerInstance = 'echo'
$Database = 'tempdb'
$ComputerName = 'echo'

#function to retrieve disk information
Function Get-DisksSpace ([string]$ComputerName)
{
Get-CIMInstance win32_logicaldisk -ComputerName $ComputerName -Filter "Drivetype=3" |
Select-Object SystemName,DeviceID,VolumeName,@{Label="Total Size";Expression={$_.Size / 1gb -as [int] }},@{Label="Free Size";Expression={$_.freespace / 1gb -as [int] }}
}

#Variable to hold output as data-table
$dataTable = Get-DisksSpace $ComputerName |  Out-DataTable
#Define Connection string
$connectionString = "Data Source=$ServerInstance;Integrated Security=True;Initial Catalog=$Database;"
#Bulk copy object instantiation
$bulkCopy = new-object ("Data.SqlClient.SqlBulkCopy") $connectionString
#Define the destination table 
$bulkCopy.DestinationTableName = "DiskInformation"
#load the data into the target
$bulkCopy.WriteToServer($dataTable)

#Query the target table to see for output
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'SELECT  * FROM DiskInformation' | format-table -AutoSize

# truncate table
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'truncate table dbo.Diskinformation'
