function Get-DiskInfo{
<#
.SYNOPSIS
Retrieves disk space information.
.DESCRIPTION
Retrieves disk information from a single computer.
.PARAMETER ComputerName
The name of the computer to query.
.PARAMETER DriveType
The type of drive to query. Defaults to 3, representing local fixed disks.
.EXAMPLE
.\Get-DiskInfo -ComputerName localhost -Verbose
#>
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$True)][string]$ComputerName,
    [int]$DriveType = 3
  )
  Write-Verbose ('Getting drive types of {0} from {1}' -f $DriveType, $ComputerName)
  Get-CimInstance -Class Win32_LogicalDisk -Filter "DriveType=$DriveType" -ComputerName $ComputerName |
  Select-Object -Property @{n='DriveLetter';e={$_.DeviceID}},
  @{n='FreeSpace(MB)';e={"{0:N2}" -f ($_.FreeSpace / 1MB)}},
  @{n='Size(GB)';e={"{0:N2}" -f ($_.Size / 1GB)}},
  @{n='FreePercent';e={"{0:N2}%" -f ($_.FreeSpace / $_.Size * 100)}}
}

Get-DiskInfo -ComputerName localhost -verbose