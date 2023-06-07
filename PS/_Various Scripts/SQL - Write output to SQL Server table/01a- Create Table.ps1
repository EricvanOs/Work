# Create table in tempdb
$ServerInstance = 'echo.pantheon.somewhere'
$Database = 'tempdb'
$query = @'
drop table if exists dbo.Diskinformation;
go
CREATE TABLE DiskInformation
(
[SystemName] VARCHAR(40) not null,
[DeviceID] VARCHAR(40) not null,
[VolumeName] VARCHAR(40) not null,
[TotalSize] int not null,
[FreeSize] int not null
)
'@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $query

# test
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'select * from DiskInformation'

