$Path = '\\pantheon\data\Courses\PowerShell\DiskSpace.JSON'
$ServerInstance = 'echo'
$Database = 'tempdb'
$query = @"
Insert into DiskInformation(SystemName,DeviceID,VolumeName,TotalSize,FreeSize)
SELECT t.*
FROM
OPENROWSET(BULK N'$Path', SINGLE_NCLOB) AS JSON
        CROSS APPLY OPENJSON(BulkColumn)
                WITH(
                Server  NVARCHAR(10),   
                DeviceID NVARCHAR(20),
		VolumeName NVARCHAR(20),
		[Total SIze] DECIMAL(5,2),
                [Free Size] DECIMAL(5,2)
		) AS t
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $query

# test
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'select * from DiskInformation'

