# extend function with verbose option  --> use [CmdletBinding()]

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [string]$ComputerName
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}


Get-CorpCompSysInfo -ComputerName hydra -Verbose