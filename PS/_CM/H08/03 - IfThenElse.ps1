$services = Get-Content -path k:\_cm\h08\services.txt

ForEach ($service in $services) {
 
    $status = (Get-Service $service).Status
    
    If ($Status -ne 'Running') {
        Start-Service $service -WhatIf
        Write-Host "Started $service" -BackgroundColor DarkRed
    } 
    Else {
        Write-Host "$service is already started" -BackgroundColor DarkGreen
    }
}



