$Path = '\\pantheon\data\Courses\PowerShell\DiskSpace.JSON'
$ServerInstance = 'echo.pantheon.somewhere'
$Database = 'tempdb'
$query = @"
Insert into DiskInformation(SystemName,DeviceID,VolumeName,TotalSize,FreeSize)
SELECT SystemName,DeviceID, isNUll(VolumeName,'') as VolumeName,[Total Size], [Free Size]
FROM
OPENROWSET(BULK N'$Path', SINGLE_CLOB) AS JSON
        CROSS APPLY OPENJSON(BulkColumn)
                WITH(
                SystemName  NVARCHAR(10),   
                DeviceID NVARCHAR(20),
				VolumeName NVARCHAR(20),
				[Total Size] DECIMAL(5,2),
                [Free Size] DECIMAL(5,2)
		) AS t
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $query

# test
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'select * from DiskInformation'

# truncate table
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'truncate table dbo.Diskinformation'


