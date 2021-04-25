$computers = 'LON-DC1','Prometheus'

#Without error checking

Foreach ($computer in $computers) {
    Get-CimInstance -Class Win32_BIOS -ComputerName $computer
} 


#With error checking

Foreach ($computer in $computers) {
    Try {
        Get-CimInstance -Class Win32_BIOS -ComputerName $computer -ErrorAction Stop
    } Catch {
        Write-Host "Error connecting to $computer"
    } Finally {
        Write-Host "BIOS query for $computer is complete"
    }
} 
