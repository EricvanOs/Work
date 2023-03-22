# Save this as \Documents\WindowsPowerShell\Modules\DemoTools\DemoTools.psm1
# (overwrite the existing file)

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [string]$ComputerName
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}
