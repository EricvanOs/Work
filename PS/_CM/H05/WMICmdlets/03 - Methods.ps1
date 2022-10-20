# 1
Get-WmiObject -ClassName Win32_Service | Get-Member 

# 2
Get-WmiObject -Class Win32_Service | Get-Member | Where-object Name -eq 'Change' | Format-List Name,Definition
Get-CimClass -Class Win32_Service | Select-Object -ExpandProperty CimClassMethods | Sort-Object -Property Name
#3
Get-CimClass -Class Win32_Service | Get-Member

