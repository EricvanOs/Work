$Path = '\\pantheon\data\Courses\PowerShell\DiskSpace.xml'
$ServerInstance = 'echo'
$Database = 'tempdb'
$query = @"
Drop table if exists XMLDiskInformation;
GO
CREATE TABLE XMLDiskInformation
(
XMLData XML,
)
GO

INSERT INTO XMLDiskInformation(XMLData)
	SELECT 
		CONVERT(XML, BulkColumn) AS BulkColumn
	FROM 
		OPENROWSET(BULK '$Path', SINGLE_BLOB) AS x;
GO
SELECT 
	p.value('(./Property)[1]', 'VARCHAR(20)') AS SystemName,
	p.value('(./Property)[2]', 'VARCHAR(30)') AS DeviceID,
	p.value('(./Property)[3]', 'VARCHAR(30)') AS VolumeName,
	p.value('(./Property)[4]', 'int') AS [Total Size],
	p.value('(./Property)[5]', 'int') AS [Free Size]
FROM XMLDiskInformation 
CROSS APPLY XMLData.nodes('/Objects/Object') t(p)
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $query