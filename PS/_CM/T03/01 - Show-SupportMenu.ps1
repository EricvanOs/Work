# The verb "Show" implies direct use of the screen and human interactivity

$continue = $true
while ($continue) {
    Write-Host "'n'n'n" # adds three blank lines
    Write-Host "=================================="
    Write-Host "          SUPPORT MENU            "
    Write-Host "=================================="
    Write-Host "                                  "
    Write-Host "1. Query computer information.    "
    Write-Host "                                  "
    Write-Host "2. Set computer state (logoff,etc)"
    Write-Host "                                  "
    Write-Host "X. Exit this menu                 "
    Write-Host "                                  "
    $choice = Read-Host  "Enter selection"

    switch ($choice) {
        "1" {
            Write-Host "'n'n'n You may enter a comma-separated list of computer names." -ForegroundColor Green
            Get-CorpCompSysInfo
        }
        "2" {
            Write-Host "'n'n'n You may enter a comma-separated list of computer names." -ForegroundColor Green
            Write-Host "Possible actions are Logoff,PowerOff,Shutdown, and Restart" -ForegroundColor Green
            Set-CorpComputerState
        }
        "X" {
            $continue = $false
        }
        default {
            Write-Host "'n'n ** Unknown Selection **" -ForegroundColor red -BackgroundColor white
        }
    }

}
