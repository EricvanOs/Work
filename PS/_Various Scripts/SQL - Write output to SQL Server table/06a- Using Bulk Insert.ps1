$Path = '\\pantheon\data\Courses\PowerShell\DiskSpace.csv'
$ComputerName = 'echo'

Get-CIMInstance win32_logicaldisk -ComputerName $ComputerName -Filter "Drivetype=3" |
Select-Object  SystemName,DeviceID,VolumeName,@{Label="Total SIze";Expression={$_.Size / 1gb -as [int] }},@{Label="Free Size";Expression={$_.freespace / 1gb -as [int] }} |
ConvertTo-Csv -NoTypeInformation | 
Set-Content -path $Path