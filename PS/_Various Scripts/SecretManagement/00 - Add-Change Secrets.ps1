# The verb "Add/Set" implies direct use of the screen and human interactivity
function Manage-HeliosSecrets {

    $continue = $true
    while ($continue) {
        Write-Host "'n'n'n" # adds three blank lines
        Write-Host "=================================="
        Write-Host "          SUPPORT MENU            "
        Write-Host "=================================="
        Write-Host "                                  "
        Write-Host "1. Add Secret to keyvault.        "
        Write-Host "                                  "
        Write-Host "2. Change Secret in keyvault      "
        Write-Host "                                  "
        Write-Host "X. Exit this menu                 "
        Write-Host "                                  "

        $choice = Read-Host  "Enter selection"

        switch ($choice) {
            "1" {
                Write-Host "Enter name of secret to be added." -ForegroundColor Green
                New-HeliosSecret
                    }
            "2" {
                Write-Host "enter name of secret where password/secret has to be changed." -ForegroundColor Green
                Set-HeliosSecret
            }
            "X" {
                $continue = $false
            }
            default {
                Write-Host "** Unknown Selection **" -ForegroundColor red -BackgroundColor white
            }
        }

    }
}


