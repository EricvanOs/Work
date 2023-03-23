# The shell looks for a PROCESS script block to know what to run
# when this is run in the pipeline

# Save this as \Documents\WindowsPowerShell\Modules\DemoTools\DemoTools.psm1
# (overwrite the existing file)

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
    PROCESS {
        foreach ($computer in $computername) {
            Write-Verbose "Now connecting to $computer"
            Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
        }
    }
}



