# Output the object to the pipeline

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
            $compsys = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
            $bios = Get-CimInstance -ClassName Win32_BIOS -ComputerName $computer
            $properties = @{'ComputerName'=$Computer;
                            'BIOSSerial'=$bios.serialnumber;
                            'Manufacturer'=$compsys.Manufacturer;  
                            'Model'=$compsys.Model}
            $output = New-Object -TypeName PSObject -Property $properties
            Write-Output $output
        }
    }
}

# press F5 to test the function
Get-CorpCompSysInfo -ComputerName LON-DC1,LON-CL1

# notice that the order of the properties is not preserved
# PowerShell uses a memory-efficient "unordered hash table" by default
