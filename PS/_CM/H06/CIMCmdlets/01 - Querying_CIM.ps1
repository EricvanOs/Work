# 1
Get-CimInstance -Namespace root -ClassName __Namespace

# 2
Get-CimInstance -ClassName Win32_Process
Get-CimInstance -ClassName Win32_Process | Get-Member

# 3
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

# 4
Get-CimInstance -Query "SELECT * FROM Win32_NetworkAdapter"
Get-CimInstance -Query "SELECT * FROM Win32_NetworkAdapter where servicename like '%ic' "

