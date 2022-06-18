Enter-PSSession -ComputerName sisyphus

$backuplocation = '\\thanatos\Public\Backups\AD'

<#	
#Create the backup folder target location first.
$backuplocation = Test-Path -Path '\\bc-core01\C$\backup'
if (!($backuplocation)){
    New-Item -Path '\\bc-core01\C$\Backup' -ItemType Folder
}
 
##Check for an existing backup at Target Network Location
$oldbackup = Test-Path -Path '\\bc-core01\C$\Backup\WindowsImageBackup\BC-Server01\'
if ($oldbackup){
    remove-item -Path '\\bc-core01\C$\Backup\WindowsImageBackup' -Recurse -Force
}
#>


 
#Check for an existing Policy
$OldPolicy = Get-Wbpolicy
if ($OldPolicy){
    Remove-WBPolicy -Policy (Get-WBPolicy -editable)
}
 
#Create New Policy
$policy = New-WBpolicy
Add-WBsystemstate -Policy $policy
$BackupTargetNetwork=New-WBbackupTarget –NetworkPath $backuplocation 
Add-WBBackupTarget -Policy $policy -Target $BackupTargetNetwork 
#Set the backup schedule
Start-WBBackup -Policy $Policy 

# rename servername-folder to servername_date

Exit-PSSession