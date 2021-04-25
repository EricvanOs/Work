# Get information about the make and model of a computer:
Get-WmiObject -Class Win32_ComputerSystem

# Get information about the BIOS of the current computer:
Get-WmiObject -Class Win32_BIOS -ComputerName .

# List installed hotfixes -- QFEs, or Windows Update files:
Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName .

# Get the username of the person currently logged on to a computer:
Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName .

# Find just the names of installed applications on the current computer:
# be carefull
# Get-WmiObject -Class Win32_Product | Format-Wide -Column 1

# Get IP addresses assigned to the current computer:
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | Format-Table -Property IPAddress

# Get a more detailed IP configuration report for the current machine:
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property [a-z]* -ExcludeProperty IPX*,WINS*

# Find network cards with DHCP enabled on the current computer:
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter 'DHCPEnabled=true' -ComputerName .

# Enable DHCP on all network adapters on the computer:somecomputer
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerName somecomputer | ForEach-Object -Process {$_.EnableDHCP()} 