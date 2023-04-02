# This is our starting point

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
        HelpMessage='Computer name to query',
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [ValidatePattern('m\w+eus')]
        [string[]]$ComputerName
    )
    PROCESS {
        foreach ($computer in $computername) {
            Write-Verbose "Now connecting to $computer"
            Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
        }
    }
}



# Save command output in a variable
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
        HelpMessage='Computer name to query',
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [ValidatePattern('m\w+eus')]
        [string[]]$ComputerName
    )
    PROCESS {
        foreach ($computer in $computername) {
            Write-Verbose "Now connecting to $computer"
            $compsys = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer #<---
        }
    }
}

Get-CorpCompSysInfo -ComputerName 'morpheus','epimetheus'
$compsys  # empty

# better solution
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
        HelpMessage='Computer name to query',
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [ValidatePattern('m\w+eus')]
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

Get-CorpCompSysInfo -ComputerName 'morpheus','epimetheus'
Get-CorpCompSysInfo -ComputerName 'morpheus','epimetheus'| Select-Object ComputerName,Manufacturer,Model,BIOSSerial