# Add the pipeline input attributes
# with this many, pressing Enter after the comma can improve readability




function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
                   HelpMessage='Computer name to query',
                   ValueFromPipeline=$True,
                   ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [ValidatePattern('LON-\w{2,3}\d{1,2}')]
        [string[]]$ComputerName
    )

    foreach ($computer in $computername) {
        Write-Verbose "Now connecting to $computer"
        Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
    }

}



