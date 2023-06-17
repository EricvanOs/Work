$Computer = 'echo.pantheon.somewhere'

# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

Set-Location C:\

Push-Location  sqlserver:\sql\selene\default\databases
$Databases = Get-ChildItem  | Select-Object -Property Name

Pop-Location

foreach ($Database in $Databases){
    $dt = get-date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\SQL\$Computer"
    $DBName = $Database.Name
    $BackupFile = "$Backupdir\$($DBName)_$($dt).diff" 
    Backup-SqlDatabase -ServerInstance $Computer -Database $DBName -BackupFile $BackupFile -Incremental

}

# apart nog de system databases (behalve master)

# Differential backups are not allowed for master DB since they require that complete backups 
# be applied without recovery as the first step while recovery. 
# When restoring the master database, restore without recovery is not allowed and not possible!!!.

$databases = 'msdb','model'
foreach ($Database in $Databases){
    $dt = get-date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\SQL\$Computer"
    $DBName = $Database
    $BackupFile = "$Backupdir\$($DBName)_$($dt).diff" 
    Backup-SqlDatabase -ServerInstance $Computer -Database $DBName -BackupFile $BackupFile -Incremental
}
