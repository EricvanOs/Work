$JSON = Get-CIMInstance win32_logicaldisk -ComputerName hqdbsp18 -Filter "Drivetype=3"  |
Select-Object  SystemName,DeviceID,VolumeName,@{Label="Total SIze";Expression={$_.Size / 1gb -as [int] }},@{Label="Free Size";Expression={$_.freespace / 1gb -as [int] }} |
ConvertTo-Json

$json | Out-File  '\\pantheon\data\Courses\PowerShell\DiskSpace.JSON' 