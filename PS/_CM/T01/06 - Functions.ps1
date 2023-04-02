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


############  ADD Comment, comment-based help
function Get-CorpCompSysInfo {
    <#
    .SYNOPSIS
    Retrieves computer information from one or more computers.
    .DESCRIPTION
    This command uses Common Information Model (CIM) commands to
    retrieve information from one or more computers. Remote computers
    must have Windows Management Framework (WMF) 3.0 or later, and
    most have PowerShell Remoting enabled.
    .PARAMETER ComputerName
    One or more computer names. This parameter accepts pipeline input.
    You cannot use IP addresses or non-canonical computer names.
    .EXAMPLE
    Get-CorpCompSystemInfo -ComputerName Morpheus,Epimetheus
    #>
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
    
    
    # Comment-based help is most easily added INSIDE the START of the function
    # as shown here.
    
    # Important points:
    # - The help will not work if any of it is syntactically wrong
    # - Add one .PARAMETER for each parameter in the function
    # - Do not number .EXAMPLE blocks and the first line of the example
    #   should be the example code


Get-Help Get-CorpCompSysInfo -Detailed
Get-Help Get-CorpCompSysInfo -ShowWindow