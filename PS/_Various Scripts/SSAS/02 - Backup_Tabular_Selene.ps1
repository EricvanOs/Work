$Computer = 'selene'
$Databases = 'AdventureWorksTab'

# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

#cd SQLSERVER:\sqlas\selene\default\databases

Set-Location c:\

foreach ($Database in $Databases){

    $dt = get-date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\Tabular\$($Computer)"
    $DBName = $Database
    $BackupFile = "$Backupdir\$($DBName)_$($dt).abf"  
    Backup-ASDatabase -Server $Computer -Name $DBname -BackupFile $BackupFile -ApplyCompression 
}

