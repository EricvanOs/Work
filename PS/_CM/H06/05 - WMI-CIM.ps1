# https://www.informit.com/articles/article.aspx?p=2477536

# WMI

Get-Command -Noun wmi* | Select-Object -Property Name

Get-WmiObject -Class Win32_OperatingSystem

Get-WmiObject -Query "SELECT * FROM win32_service WHERE name='Spooler'" -ComputerName localhost,hypnos,hydra | 
Format-List -Property PSComputerName,Name,State,Status

$mem2spool = Get-WmiObject -Query "SELECT * FROM win32_service WHERE name='Spooler'"
$mem2spool | Get-Member -MemberType Method | Select-Object -Property Name


$mem2spool.StopService()
$mem2spool.StartService()



# CIM
Get-Command -Module CimCmdlets | Select-Object -Property Name

Get-CimInstance -ClassName Win32_BIOS

Get-CimInstance -Query "SELECT * FROM Win32_Process WHERE name LIKE 's%'"

Get-CimInstance -ClassName win32_process -Filter "name like 's%'"


$mem1spooler = Get-CimInstance -ComputerName hydra -query "SELECT * FROM win32_service WHERE name='Spooler'"
$mem1spooler | Get-Member -MemberType Method

Get-CimInstance -ComputerName hydra -query "SELECT * FROM win32_service WHERE name='Spooler'" | Invoke-CimMethod -MethodName StopService  -WhatIf

Get-CimClass -ClassName Win32_Service  | Select-Object -ExpandProperty CimClassMethods



