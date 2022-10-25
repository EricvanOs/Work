Param (
    [string]$ComputerName = 'Hydra'
)

$bios = Get-CimInstance Win32_BIOS -ComputerName $ComputerName

Write-Host "The BIOS information for $ComputerName"
$bios


# test
<#
Set-Location -Path C:\Work\PS\_CM\H07B
#>