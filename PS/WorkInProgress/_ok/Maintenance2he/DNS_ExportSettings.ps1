function DNS_ExportSettings{
    param()

    $ses = New-PSSession -ComputerName sisyphus
    Invoke-Command -Session $ses -ScriptBlock{

        $zones = Get-DnsServerZone | Where-Object{$_.isautocreated -eq $false -and $_.isReverselookupZone -eq $false};
        $d = (get-date).ToString("yyyy-MM-dd");
        $bd = '\\pantheon\data\Misc\Backups\DNS\';
        new-item -Path $bd  -name $d -ItemType directory;

        foreach ($zone in $zones){

            $a = $zone.ZoneName 
            Export-DnsServerZone -ComputerName sisyphus -name  $a  -FileName ('..\..\..\' + 'a.dns')
            move-item -path 'c:\a.dns' -Destination ($bd + $d + '\' + "$a.dns")

        };

    }

    Remove-PSSession $ses
}