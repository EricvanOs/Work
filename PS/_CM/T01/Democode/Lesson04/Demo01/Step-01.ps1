# This is our starting point





function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,HelpMessage='Computer name to query')]
        [Alias('hostname')]
        [ValidatePattern('LON-\w{2,3}\d{1,2}')]
        [string[]]$ComputerName
    )

    foreach ($computer in $computername) {
        Write-Verbose "Now connecting to $computer"
        Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
    }

}


