# Best to capture and save to a private variable
$computers = "morpheus","dontexists"
foreach ($computer in $computers) {
    try {
        Get-CimInstance -ClassName Win32_BIOS -ComputerName $computer -ErrorAction Stop
    } catch {
        $MyError = $_
        Write-Warning "CAUGHT ERROR ON $computer"
        Write-Warning $myerror
        $myerror | Get-Member
    }
}
