# Add a call to the function at the end of the script
# so that you can run the script and test the function

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}

Get-CorpCompSysInfo -ComputerName localhost

