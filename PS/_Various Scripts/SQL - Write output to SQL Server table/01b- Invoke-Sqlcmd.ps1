$ServerInstance = 'echo'
$Database = 'tempdb'
$ComputerName = 'echo'

#Function to manipulate the data
Function writeDiskInfo{
    param($server,$devId,$volName,$frSpace,$totSpace)

    $totSpace=[math]::Round(($totSpace/1073741824),2)
    $frSpace=[Math]::Round(($frSpace/1073741824),2)
    $usedSpace = $totSpace - $frspace
    $usedSpace=[Math]::Round($usedSpace,2)

    # Data preparation for loading data into SQL table 
    $Query = @"
    INSERT INTO [dbo].[DiskInformation](SystemName,DeviceID,VolumeName,TotalSize,FreeSize)
    VALUES ('$SERVER','$devId','$volName',$totSpace,$usedSpace)
"@      

    Invoke-sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $Query
}

#Query WMI query to store the result in a varaible
$items = Get-CimInstance win32_logicaldisk -ComputerName $ComputerName |  Where-Object {$_.drivetype -eq 3}

#Loop through array
foreach ($item in $items){
    #Call the function to transform the data and prepare the data for insertion
    writeDiskInfo  -server $ServerInstance -devId $item.DeviceID -volName $item.VolumeName -frSpace $item.FreeSpace -totSpace $item.Size
}


# Query the destination table to view the result
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'SELECT  * FROM DiskInformation' | format-table -AutoSize


# truncate table
Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query 'truncate table dbo.Diskinformation'
