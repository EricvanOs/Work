# Run this entire script to see the differences
$VerbosePreference = 'Continue'
$Computers = "LON-DC1","NOTONLINE","LON-SVR1"


Write-Verbose "PASS 1: Attempt to trap a non-terminating error"
try {
    Get-CimInstance -ClassName Win32_BIOS -ComputerName $computers
} catch {
    Write-Warning "The command on this line never runs because the error is never trapped"
}


Write-Verbose "PASS 2: Attempt to trap a terminating error"
try {
    Get-CimInstance -ClassName Win32_BIOS -ComputerName $computers -ErrorAction Stop
} catch {
    Write-Warning "The command on this line runs, but neither of the available computers are queried because the overall command terminates after receiving and error against NOTONLINE"
}



Write-Verbose "PASS 3: That is why we enumerate - so we only try one computer at a time"
foreach ($computer in $computers) {
    try {
        Get-CimInstance -ClassName Win32_BIOS -ComputerName $computer -ErrorAction Stop
    } catch {
        Write-Warning "Trapped error on $computer"
    }
}
