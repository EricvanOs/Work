function GPO_Backup{
    param()

    $ses = New-PSSession -ComputerName sisyphus
    Invoke-Command -Session $ses -ScriptBlock{

        $BackupPath = '\\pantheon\data\misc\Backups\GPO'  + '\' + (get-date).ToString("yyyy-MM-dd-hh-mm-ss")

        New-Item $BackupPath  -type directory

        Get-GPO -Domain pantheon.somewhere -All | Backup-GPO -Path $BackupPath  
        
    }

    Remove-PSSession $ses
}


