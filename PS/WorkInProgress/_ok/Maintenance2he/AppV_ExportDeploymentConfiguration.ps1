$ses = New-PSSession -ComputerName themis
Invoke-Command -Session $ses -ScriptBlock{

    $BackupPath = '\\pantheon\data\Misc\Backups\AppV'  + '\' + (get-date).ToString("yyyy-MM-dd") 
    New-Item $BackupPath  -type directory

    $Packages = Get-AppvServerPackage
    foreach ($Package in $Packages){

        $PackageName = $Package.Name
    
        $BFilename = $BackupPath + '\' + "$PackageName.xml"

        Get-AppvServerPackageDeploymentConfiguration -name $PackageName | Out-file -filepath  $BFilename
    }
}
Remove-PSSession $ses


