# WMI

Get-Command -Noun wmi* | Select-Object -Property Name

Get-WmiObject -Class Win32_OperatingSystem

Get-WmiObject -Query "SELECT * FROM win32_service WHERE name='Spooler'" -ComputerName localhost,echo,hydra

# get all methods, will not work with PS 7 use ISE
Get-WmiObject -List -Namespace "root\cimv2" -Class Win32_Service | Select-Object -ExpandProperty Methods | Select-Object -Property Name






