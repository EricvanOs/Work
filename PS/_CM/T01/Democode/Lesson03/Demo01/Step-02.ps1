# Define parameter as mandatory


function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]

        [string]$ComputerName
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}

