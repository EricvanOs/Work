$services = Get-Content -path C:\Work\PS\_CM\H07\services.txt

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





