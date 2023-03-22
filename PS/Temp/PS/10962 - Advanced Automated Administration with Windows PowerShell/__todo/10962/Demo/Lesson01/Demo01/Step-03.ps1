# Create a parameter block, define a parameter, and use the parameter
# in place of the hardcoded value



Param(
    [string]$ComputerName
)
Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName

