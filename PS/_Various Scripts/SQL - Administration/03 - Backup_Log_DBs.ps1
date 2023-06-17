$Computer = 'echo.pantheon.somewhere'

# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

Set-Location C:\

Push-Location  sqlserver:\sql\selene\default\databases
$Databases = Get-ChildItem | where-object{$_.RecoveryModel -ne 'Simple'} | Select-Object -Property Name

Pop-Location

foreach ($Database in $Databases){
    $dt = get-date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\SQL\$Computer"
    $DBName = $Database.Name
    $BackupFile = "$Backupdir\$($DBName)_$($dt).trn" 
    Backup-SqlDatabase -ServerInstance $Computer -Database $DBName -BackupFile $BackupFile -BackupAction Log
}

# apart nog de system database model

$databases = 'model'
foreach ($Database in $Databases){
    $dt = get-date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\SQL\$Computer"
    $DBName = $Database
    $BackupFile = "$Backupdir\$($DBName)_$($dt).trn" 
    Backup-SqlDatabase -ServerInstance $Computer -Database $DBName -BackupFile $BackupFile
}
