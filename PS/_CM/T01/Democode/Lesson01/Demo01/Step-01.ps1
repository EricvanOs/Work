# Test and debug commands one at a time in the console

Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName localhost


######### in a function 
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}



Get-CorpCompSysInfo -ComputerName localhost