# Starting point: we will build a menu for the tools in this
# module. These are basically unchanged since Module 1.

# Save this as \Documents\WindowsPowerShell\Modules\DemoTools\DemoTools.psm1
# (overwrite any existing file)



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
Get-CorpCompSystemInfo -ComputerName LON-DC1,LON-CL1
#>
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

function Set-CorpComputerState {
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact="High")]
    param(
        [Parameter(Mandatory=$True,
                   HelpMessage='Computer name to set state for',
                   ValueFromPipeline=$True,
                   ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [string[]]$ComputerName,

        [Parameter(Mandatory=$True,
                   HelpMessage='Action to take: PowerOff, Shutdown, Restart, or Logoff')]
        [ValidateSet('PowerOff','Shutdown','Restart','Logoff')]
        [string]$State,

        [switch]$force
    )
    BEGIN {
        switch ($action) {
            'LogOff'   { $_action = 0 }
            'Shutdown' { $_action = 1 }
            'Restart'   { $_action = 2 }
            'PowerOff' { $_action = 8 }
        }
        if ($force) { $_action += 4 }
        Write-Verbose "Action value is $_action"
    }
    PROCESS {
        foreach ($computer in $computername) {
            if ($PSCmdlet.ShouldProcess("$computer - action is $action")) {
                Write-Verbose "Contacting $computer"
                $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName -EnableAllPrivileges
                $os.win32shutdown($_action) | out-null
            }
        }
    }
}
