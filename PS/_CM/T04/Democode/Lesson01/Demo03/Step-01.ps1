
# TECHNIQUE 1: $error built-in collection
# Will contain terminating and non-terminating errors
# $error[0] is the most recent
# $error.clear() clears it out - not always a good practice
$computers = "LON-DC1","NOTONLINE","LON-SVR1"
foreach ($computer in $computers) {
    try {
        Get-CimInstance -ClassName Win32_BIOS -ComputerName $computer
    } catch {
        Write-Warning "CAUGHT ERROR ON $computer"
        Write-Warning $error[0]
        $error[0] | Get-Member
    }
}
