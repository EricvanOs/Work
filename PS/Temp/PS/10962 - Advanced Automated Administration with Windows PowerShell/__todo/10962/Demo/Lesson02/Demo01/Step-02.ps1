# Save this as \Documents\WindowsPowerShell\Modules\DemoTools\DemoTools.psm1


function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}

