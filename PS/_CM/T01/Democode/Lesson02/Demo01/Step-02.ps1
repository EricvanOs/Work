function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}



