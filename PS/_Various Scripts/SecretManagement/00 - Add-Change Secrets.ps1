# The verb "Add/Set" implies direct use of the screen and human interactivity
function Manage-HeliosSecrets {

    $continue = $true
    while ($continue) {
        Write-Host "`n" # adds a blank line
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

        Try {
            [ValidateSet('1','2','X')]
            [string]$choice = Read-Host "Give selection" -ErrorAction Stop
        }
        Catch{
            Write-Host "** Unknown Selection **" -ForegroundColor red -BackgroundColor white
            Continue
        }
    
        switch ($choice) {
            "1" {
                Write-Host "Enter name of secret to be added." -ForegroundColor Green
                $newname = Read-Host 'Name of secret'
                $newsecret = Read-Host 'password or secret'
                New-HeliosSecret -Name $newname -Secret $newsecret
                }
            "2" {
                Write-Host "Enter name of secret where password/secret has to be changed." -ForegroundColor Green
                $oldname = Read-Host 'Name of secret of be changed'
                $newsecret = Read-Host 'New password or secret'
                Set-HeliosSecret -Name $oldname -Secret $newsecret
            }
            "X" {
                $continue = $false
            }

        }

    }
}


