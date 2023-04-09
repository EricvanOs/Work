function NPS_ExportSettings{
    param()

    $ses = New-PSSession -ComputerName themis
    Invoke-Command -Session $ses -ScriptBlock{

        Export-NpsConfiguration -Path ('\\pantheon\data\misc\Backups\NPS\NPSConfig_' + (get-date).ToString("yyyy-MM-dd") + '.xml')

    }

    Remove-PSSession -Session $ses
}


