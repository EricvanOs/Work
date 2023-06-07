$ServerInstance = 'echo.pantheon.somewhere'
$Database = 'tempdb'
$ComputerName = 'echo'
$Query = @'
	INSERT INTO [dbo].[DiskInformation](SystemName,DeviceID,VolumeName,TotalSize,FreeSize)
	VALUES ('{0}','{1}','{2}','{3}','{4}')
'@

Try {
    #Define connction string of target database
	$connectionString = "Data Source=$ServerInstance;Initial Catalog=$Database;Integrated Security=SSPI"
    # connection object initialization
	$conn = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    #Open the Connection 
	$conn.Open()
    # Prepare the SQL 
	$cmd = $conn.CreateCommand()
    #WMI ouput transformation to SQL table
	Get-CimInstance win32_logicaldisk -ComputerName $ComputerName -Filter "Drivetype=3" |
    Select-Object  SystemName,DeviceID,VolumeName,@{Label="TotalSize";Expression={$_.Size / 1gb -as [int] }},@{Label="FreeSize";Expression={$_.freespace / 1gb -as [int] }} |
		ForEach-Object{
			$cmd.CommandText = $Query -f $_.SystemName, $_.DeviceID, $_.VolumeName, $_.TotalSize, $_.FreeSize
			$cmd.ExecuteNonQuery()
	}
    #Close the connection
	$conn.Close()
}
Catch {
	Throw $_
}

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'SELECT  * from DiskInformation' | format-table -AutoSize

# truncate table
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'truncate table dbo.Diskinformation'