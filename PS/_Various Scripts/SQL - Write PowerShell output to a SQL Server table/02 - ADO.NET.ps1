#Invoke-sqlcmd Connection string parameters
$params = @{'server'='Echo';'Database'='tempdb'}
#Server to query WMI class win32_logicalDisks
$server = 'Echo'
#Prepare Insert Statement
$insert = @'
	INSERT INTO [dbo].[DiskInformation](SystemName,DeviceID,VolumeName,TotalSize,FreeSize)
	VALUES ('{0}','{1}','{2}','{3}','{4}')
'@
 
 
Try {
    #Define connction string of target database
	$connectionString = 'Data Source=Echo;Initial Catalog=tempdb;Integrated Security=SSPI'
    # connection object initialization
	$conn = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    #Open the Connection 
	$conn.Open()
    # Prepare the SQL 
	$cmd = $conn.CreateCommand()
    #WMI ouput transformation to SQL table
	Get-CimInstance win32_logicaldisk -ComputerName $server -Filter "Drivetype=3" |`
    Select-Object  SystemName,DeviceID,VolumeName,@{Label="TotalSize";Expression={$_.Size / 1gb -as [int] }},@{Label="FreeSize";Expression={$_.freespace / 1gb -as [int] }}|`
		ForEach-Object{
			$cmd.CommandText = $insert -f $_.SystemName, $_.DeviceID, $_.VolumeName, $_.TotalSize, $_.FreeSize
			$cmd.ExecuteNonQuery()
	}
    #Close the connection
	$conn.Close()
}
Catch {
	Throw $_
}
 
Invoke-Sqlcmd @params -Query "SELECT  * DiskInformation" | format-table -AutoSize