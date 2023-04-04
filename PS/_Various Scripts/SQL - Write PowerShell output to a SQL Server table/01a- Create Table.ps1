# Create table in tempdb
$ServerInstance = 'echo'
$Database = 'tempdb'
$query = @'
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

