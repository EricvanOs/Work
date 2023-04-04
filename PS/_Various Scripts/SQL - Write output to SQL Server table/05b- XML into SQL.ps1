$Path = '\\pantheon\data\Courses\PowerShell\DiskSpace.xml'
$ServerInstance = 'echo'
$Database = 'tempdb'
$query = @"
CREATE TABLE XMLDiskInformation
(
XMLData XML,
)
--truncate table XMLwithOpenXML

INSERT INTO XMLDiskInformation(XMLData)
	SELECT 
		CONVERT(XML, BulkColumn) AS BulkColumn
	FROM 
		OPENROWSET(BULK '$Path', SINGLE_BLOB) AS x;

SELECT XMLData FROM XMLDiskInformation

	SELECT 
    p.value('(./Property)[1]', 'VARCHAR(20)') AS SystemName,
	p.value('(./Property)[2]', 'VARCHAR(30)') AS DeviceID,
	p.value('(./Property)[3]', 'VARCHAR(30)') AS VolumeName,
	p.value('(./Property)[4]', 'int') AS [Total SIze],
	p.value('(./Property)[5]', 'int') AS [Free Size]
FROM tbl_XMLDisk 
    CROSS APPLY XMLData.nodes('/Objects/Object') t(p)
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $query