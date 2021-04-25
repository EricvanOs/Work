# make backup of specific list of databases
$Computer = 'selene'
$Databases = 'Adventure Works DW EE', 'Contoso_Retail' , 'FoodMart' , 'MDX','GalacticOLAP','Waremart 2005','FAA_MD_P_cci'

# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

#cd SQLSERVER:\sqlas\selene\alpha\databases


Set-Location c:\

foreach ($Database in $Databases){

    $dt = get-date -format yyyyMMddHHmmss
    $Backupdir = "\\pantheon\data\Misc\Backups\SSAS\$($Computer)"
    $DBName = $Database
    $BackupFile = "$($DBName)_$($dt).abf" 
    Backup-ASDatabase -Server "$($Computer)\alpha" -Name $DBname -BackupFile $BackupFile -ApplyCompression 
}

