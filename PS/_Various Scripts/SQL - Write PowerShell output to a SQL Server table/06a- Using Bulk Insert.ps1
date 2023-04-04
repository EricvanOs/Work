Get-WmiObject win32_logicaldisk -ComputerName hqdbsp18 -Filter "Drivetype=3" |`
select  SystemName,DeviceID,VolumeName,@{Label="Total SIze";Expression={$_.Size / 1gb -as [int] }},@{Label="Free Size";Expression={$_.freespace / 1gb -as [int] }} |`
ConvertTo-Csv -NoTypeInformation| Set-Content -path \\hqdbt01\f$\PowerSQL\DiskSpace.csv