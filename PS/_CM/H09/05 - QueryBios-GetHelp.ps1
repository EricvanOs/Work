<#
.SYNOPSIS
Queries a remote computer for BIOS information.
.DESCRIPTION
Use this script to obtain BIOS inforamtion from remote computers. You must have sufficient permissions to query this information.
.PARAMETER ComputerName
The name of the remote computer that is being queried.
.EXAMPLE
.\Query-Bios.ps1 -ComputerName LON-DC1
.EXAMPLE
.\Query-Bios.ps1 LON-DC1
#>

Param (
    [string]$ComputerName
)

If ($ComputerName -eq '') 
{
    Write-Host 'A ComputerName is required.'
} 
Else 
{
    Get-CimInstance Win32_BIOS -ComputerName $ComputerName
}


# test

Set-Location -Path K:\_cm\H09

get-help '.\05 - QueryBios-GetHelp.ps1'