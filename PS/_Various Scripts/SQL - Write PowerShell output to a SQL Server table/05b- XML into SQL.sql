CREATE TABLE tbl_XMLDisk
(
XMLData XML,
)
--truncate table XMLwithOpenXML
 
INSERT INTO tbl_XMLDisk(XMLData)
	SELECT 
		CONVERT(XML, BulkColumn) AS BulkColumn
	FROM 
		OPENROWSET(BULK 'f:\PowerSQL\DiskSpace.xml', SINGLE_BLOB) AS x;
 
SELECT XMLData FROM tbl_XMLDisk
 
	SELECT 
    p.value('(./Property)[1]', 'VARCHAR(20)') AS SystemName,
	p.value('(./Property)[2]', 'VARCHAR(30)') AS DeviceID,
	p.value('(./Property)[3]', 'VARCHAR(30)') AS VolumeName,
	p.value('(./Property)[4]', 'int') AS [Total SIze],
	p.value('(./Property)[5]', 'int') AS [Free Size]
FROM tbl_XMLDisk 
    CROSS APPLY XMLData.nodes('/Objects/Object') t(p)