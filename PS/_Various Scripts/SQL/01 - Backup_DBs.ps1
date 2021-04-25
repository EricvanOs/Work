$Computer = 'eos'

# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

Set-Location -Path c:\

Push-Location  sqlserver:\sql\$Computer\default\databases
$Databases = Get-ChildItem 
Pop-Location

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


