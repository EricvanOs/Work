# Highlight and run each section below to understand
# the error handling options.


# The default: SilentlyContinue
# Displays error and keeps going
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-DC1,NOTONLINE,LON-SVR1


# No error, keep going
$ErrorActionPreference = 'SilentlyContinue'
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-DC1,NOTONLINE,LON-SVR1


# Asked what to do, selecting "Yes" or "Yes to All" will display the error and keep going
# Selecting "Halt Command" will stop the command and not display the original error. Selecting "Suspend" will suspend the command which
# is indicated in the console window by ">>"
$ErrorActionPreference = 'Inquire'
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-DC1,NOTONLINE,LON-SVR1


# Generate terminating EXCEPTION and stop
$ErrorActionPreference = 'Stop'
Get-CimInstance -ClassName Win32_BIOS -ComputerName LON-DC1,NOTONLINE,LON-SVR1


# Only terminating exceptions can be trapped


# Set default back
$ErrorActionPreference = 'Continue'
