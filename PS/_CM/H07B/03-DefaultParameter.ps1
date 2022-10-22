Param (
    [string]$ComputerName = 'Hydra'
)

$bios = Get-CimInstance Win32_BIOS -ComputerName $ComputerName

Write-Host "The BIOS information for $ComputerName"
$bios


# test
<#
Set-Location -Path K:\_CM\H07B
#>