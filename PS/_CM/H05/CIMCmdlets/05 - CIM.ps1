# CIM
Get-Command -Module CimCmdlets | Select-Object -Property Name

Get-CimInstance -ClassName Win32_BIOS

Get-CimInstance -Query "SELECT * FROM Win32_Process WHERE name LIKE 's%'"

Get-CimInstance -ClassName win32_process -Filter "name like 's%'"

# methods of a CimClass e.g. Win32_Service
Get-CimClass -ClassName Win32_Service  | Select-Object -ExpandProperty CimClassMethods

Get-CimInstance -ComputerName hydra -query "SELECT * FROM win32_service WHERE name='Spooler'" | Invoke-CimMethod -MethodName StopService  -WhatIf





