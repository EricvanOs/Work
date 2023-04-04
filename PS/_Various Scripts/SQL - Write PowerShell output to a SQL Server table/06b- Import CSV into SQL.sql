--Create table.
 
CREATE TABLE tbl_CSVDisk
(
[SystemName] VARCHAR(40),
[DeviceID] VARCHAR(40),
[VolumeName] VARCHAR(40),
[TotalSize] VARCHAR(40),
[FreeSize] VARCHAR(40)
)
 
--Load the data into the SQL table starting with 2 row, comma(‘,’) as delimiter and newline as 
--rowseparator
 
BULK
INSERT tbl_CSVDisk
FROM 'F:\PowerSQL\DiskSpace.csv'
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
 
FROM tbl_CSVDisk