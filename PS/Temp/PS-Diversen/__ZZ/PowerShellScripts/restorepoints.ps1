cls
Write-Host "Getting date..."
$Date = Get-Date
Write-Host "Got date $Date"

Write-Host "Test system restore..."
$Val = Get-ItemProperty -Path "hklm:SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"

If (($Val.RPSessionInterval) -eq 0) {
	Enable-ComputerRestore -Drive c:\ 
	}

try {
	Write-Host "Getting last restore point..."
	$Restorepoint = Get-ComputerRestorePoint | Sort-Object $_.sequencenumber | select-object -Last 1 -ErrorAction Stop
	Write-Host "Found restore point $Restorepoint"
	Write-Host "Getting creation time..."
	$Creationtime = ([WMI]'').ConvertToDateTime($Restorepoint.CreationTime)
	Write-Host "Found creationtime $Creationtime"

	Write-Host "Testing date vs last restore point"
	((Get-Date) - $Creationtime).days
	If (((Get-Date) - $Creationtime).days -ge "7") {
		Checkpoint-Computer -Description "Restorepoint created by script - $date"
		}
	Else {"restorepoint not old enough"}
}
catch {
	"no restorepoints"
	CheckPoint-Computer -Description "First restorepoint" 
	}