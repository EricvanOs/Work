function DHCP_ExportSettings{
    param()

    $ses = New-PSSession -ComputerName sisyphus
    Invoke-Command -Session $ses -ScriptBlock{
        Export-DhcpServer -ComputerName sisyphus.pantheon.somewhere -File ('\\pantheon\data\Misc\Backups\DHCP\DHCPConfig_' + (get-date).ToString("yyyy-MM-dd") + '.xml')
    }

    Remove-PSSession $ses
}
