# Create table in tempdb

$query = @'
CREATE TABLE tbl_PoShDisk
(
[SystemName] VARCHAR(40) not null,
[DeviceID] VARCHAR(40) not null,
[VolumeName] VARCHAR(40) not null,
[TotalSize] int not null,
[FreeSize] int not null
)
'@

Invoke-Sqlcmd -ServerInstance echo -Database tempdb -Query $query



