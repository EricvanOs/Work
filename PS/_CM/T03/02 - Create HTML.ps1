﻿#region fuunction Get-CorpCompSysInfo
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
#endregion

Set-Location -Path C:\work\ps\_cm\T03

# Produce HTML fragments

$fragment1 = Get-CorpCompSysInfo -ComputerName Morpheus |
             ConvertTo-HTML -Fragment -PreContent "<h2>Computer System</h2>" -As List |
             Out-String

# ConvertTo-HTML produces an array of strings. What we will need later is a single string.
# So we use Out-String to process the array into a single string.

$fragment2 = Get-Process   |
             ConvertTo-HTML -Fragment -Property Name,ID,VM,PM,WS -PreContent "<h2>Processes</h2>" -As Table |
             Out-String


# Now we combine the fragments
ConvertTo-HTML -Title "Report for Morpheus" -Body "<h1>Report for Morpheus</h1>",$fragment1,$fragment2 |
Out-File .\morpheus.html


