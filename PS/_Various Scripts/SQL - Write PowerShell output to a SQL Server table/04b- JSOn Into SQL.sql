SELECT t.*
 FROM
OPENROWSET(BULK N'\\hqdbt01\f$\PowerSQL\DiskSpace.JSON', SINGLE_NCLOB) AS JSON
            CROSS APPLY OPENJSON(BulkColumn)
                        WITH(
                           Server  NVARCHAR(10),   
                   	DeviceID NVARCHAR(20),
		 VolumeName NVARCHAR(20),
		 [Total SIze] DECIMAL(5,2),
                           [Free Size] DECIMAL(5,2)
		) AS t