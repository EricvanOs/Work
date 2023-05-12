# 1
Get-Process | Sort-Object -Property VM -Descending | Select-Object -First 10

# 2
Get-Date | Select-Object -Property DayOfWeek

# 3
Get-WinEvent -MaxEvents 10 -LogName Security | Select-Object -Property ID,TimeCreated,Message

# 4
Get-ADComputer -Filter * -Properties OperatingSystem | Sort-Object -Property OperatingSystem | 
  Select-Object -Property OperatingSystem,Name | Format-List -GroupBy OperatingSystem -Property Name

# 5
Get-ADComputer -Filter * -Properties OperatingSystem | Sort-Object -Property OperatingSystem | 
  Select-Object -Property OperatingSystem,Name | Group-Object OperatingSystem 

# 6
Get-ADComputer -Filter * -Properties OperatingSystem | Sort-Object -Property OperatingSystem | 
  Select-Object -Property OperatingSystem,Name | Group-Object OperatingSystem | Select-Object -ExpandProperty group

# 7
Get-ADComputer -Filter * -Properties OperatingSystem | Sort-Object -Property OperatingSystem | 
  Select-Object -Property OperatingSystem,Name | Group-Object OperatingSystem | Select-Object -ExpandProperty group |
  Select-Object Name,OperatingSystem

