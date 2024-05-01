$Computer = 'echo'

Set-Location -Path C:\

Push-Location  sqlserver:\sql\$Computer\default\databases
$Databases = Get-ChildItem 
Pop-Location

$ProgressPreference = 'SilentlyContinue'

foreach ($Database in $Databases){
    $dt = Get-Date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\SQL\$Computer"
    $DBName = $Database.Name
    $BackupFile = "$Backupdir\$($DBName)_$($dt).bak" 
    Backup-SqlDatabase -ServerInstance $Computer -Database $DBName -BackupFile $BackupFile 
}

# apart nog de system databases

$databases = 'master','msdb','model'
foreach ($Database in $Databases){
    $dt = Get-Date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\SQL\$Computer"
    $DBName = $Database
    $BackupFile = "$Backupdir\$($DBName)_$($dt).bak" 
    Backup-SqlDatabase -ServerInstance $Computer -Database $DBName -BackupFile $BackupFile
}

$ProgressPreference = 'Continue'
