Param (
    [string]$ComputerName='Hydra'
)

$bios = Get-WmiObject Win32_BIOS -ComputerName $ComputerName



Write-Host "The BIOS information for $ComputerName"
$bios

<#
# test
New-PSDrive -Name K -Root C:\Work\PS -PSProvider FileSystem  

Set-Location -Path K:\_CM\H09

# cleanup
Remove-PSDrive K
#>