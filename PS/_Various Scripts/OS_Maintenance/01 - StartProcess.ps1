$StartParams = @{
    FilePath = "$Env:SystemRoot\REGEDIT.exe"
    ArgumentList = '/s','C:\file.reg'
    Verb = 'RunAs'
    PassThru = $True
    Wait = $True
}
$Proc = Start-Process @StartParams

If ($Proc.ExitCode -eq 0) { Write-Host 'Success!' }
Else { Write-Host "Fail! Exit code: $($Proc.ExitCode)" }


