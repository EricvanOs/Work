# Notice that a comma separates parameters
# and that parameter attributes are per-parameter

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage='Computer name to query')]
        [Alias('hostname')]
        [string]$ComputerName,

        [Parameter(HelpMessage='This is for example only')]
        [int]$AnotherParameter
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}
