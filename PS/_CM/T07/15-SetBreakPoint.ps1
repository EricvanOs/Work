# run from command prompt in ISE/PS5

function Get-ArchitectureInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$ComputerName
    )
    PROCESS {
        foreach ($computer in $computername) {
            # All CPUs should be the same so only get one
            $proc = Get-CimInstance -ClassName Win32_Processor -ComputerName $computer |
                     Select-Object -first 1

            $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer

            $properties = @{'ComputerName'=$Computer;
                            'OSArchitecture'=$os.osarchitecture;
                            'ProcArchitecture'=$proc.addresswidth}
            $obj = New-Object -TypeName PSObject -Property $properties
            Write-Output $obj
        }
    }
}

Set-Location -Path C:\work\ps\_CM\T07
# cleanup from previous run
Remove-Item -Path .\debug.txt -ErrorAction SilentlyContinue
Get-PSBreakpoint | Remove-PSBreakpoint

# Set a breakpoint on line 18.
Set-PSBreakpoint -Script .\15-SetBreakPoint.ps1 -Line 18

# Also set a breakpoint that outputs data to a debugging file
# each time $properties is written to
Set-PSBreakpoint -Script .\15-SetBreakPoint.ps1 -Variable properties -Mode Write -Action { $properties | Out-File -FilePath .\debug.txt -append }

# This will run the command
Get-ArchitectureInfo -ComputerName 'Morpheus','Epimetheus' |
Select-Object -Property ComputerName


Get-Content -Path .\debug.txt

