$computer = 'LocalHost' 
$namespace = 'root\CIMV2' 
Get-WmiObject -class Win32_DiskDrive -computername $computer -namespace $namespace

#betere optie befruik CIM
Get-CimInstance -ClassName Win32_DiskDrive -ComputerName $computer -Namespace $namespace

# "nog" betere optie (no parameter -ComputerName)
Get-Disk 