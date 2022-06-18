$network = Get-NetIPAddress | Where-Object{$_.ipv4address -like '192.168.82.*'}
if( ($network | Measure-Object).count -eq 1){

    $aa = Get-NetAdapter | where-object{$_.ifindex -eq $network.InterfaceIndex}
    Rename-NetAdapter -Name $aa.name -NewName '82-network'
}

