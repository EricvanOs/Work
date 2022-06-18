Import-Module -Name mytools

Get-Module -Name mytools

Get-DiskInfo -ComputerName Sthenno

Save-Help -DestinationPath '\\pantheon\data\Misc\Powershell-Help' -ErrorAction SilentlyContinue
Update-Help -SourcePath '\\pantheon\data\Misc\Powershell-Help' -ErrorAction SilentlyContinue


Set-Scheduledtask