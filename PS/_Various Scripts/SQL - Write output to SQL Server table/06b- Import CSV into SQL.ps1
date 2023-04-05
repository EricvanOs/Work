$Path = '\\pantheon\data\Courses\PowerShell\DiskSpace.csv'
$ServerInstance = 'echo'
$Database = 'tempdb'
$query = @"
drop table if exists CSVDiskInformation
GO
CREATE TABLE CSVDiskInformation
(
[SystemName] VARCHAR(40),
[DeviceID] VARCHAR(40),
[VolumeName] VARCHAR(40),
[TotalSize] VARCHAR(40),
[FreeSize] VARCHAR(40)
)
GO

--Load the data into the SQL table starting with 2 row, comma(',') as delimiter and newline as rowseparator

BULK INSERT CSVDiskInformation
FROM '$Path'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO
--Check the content of the table.
SELECT REPLACE(systemName,'"','') systemName,
REPLACE([DeviceID],'"','') [DeviceID],
REPLACE([VolumeName],'"','') [VolumeName],
REPLACE([TotalSize],'"','') [TotalSize],
REPLACE([FreeSize],'"','') [FreeSize]
FROM CSVDiskInformation
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $query