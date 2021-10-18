# 1
Get-CimClass -Class Win32_Service | Select-Object -ExpandProperty CimClassMethods | Sort-Object -Property Name

#2
Get-CimClass -Class Win32_Service | Get-Member

