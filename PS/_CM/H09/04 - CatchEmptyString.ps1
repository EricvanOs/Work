Param (
    [string]$ComputerName
)

If ($ComputerName -eq "") {
    Write-Host "A ComputerName is required."
} Else {
    Get-CimInstance Win32_BIOS -ComputerName $ComputerName
}


# test
New-PSDrive -Name K -Root C:\Work\PS -PSProvider FileSystem  

Set-Location -Path K:\_CM\H09

# cleanup
Remove-PSDrive K