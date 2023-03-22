
# TECHNIQUE 2: ErrorVariable
# Variables names don't include the $
# Prefix with + to append errors
# Only includes errors from that command
$computers = "LON-DC1","NOTONLINE","LON-SVR1"
foreach ($computer in $computers) {
    try {
        Get-CimInstance -ClassName Win32_BIOS -ComputerName $computer -ErrorVariable MyBad
    } catch {
        Write-Warning "CAUGHT ERROR ON $computer"
        Write-Warning $mybad
        $mybad | Get-Member
    }
}
