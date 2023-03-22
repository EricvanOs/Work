
# TECHNIQUE 3: $_
# In most contexts will include last error
# Can be lost if $_ is used for something else
# Best to capture and save to a private variable
$computers = "LON-DC1","NOTONLINE","LON-SVR1"
foreach ($computer in $computers) {
    try {
        Get-CimInstance -ClassName Win32_BIOS -ComputerName $computer 
    } catch {
        $MyError = $_
        Write-Warning "CAUGHT ERROR ON $computer"
        Write-Warning $myerror
        $myerror | Get-Member
    }
}
