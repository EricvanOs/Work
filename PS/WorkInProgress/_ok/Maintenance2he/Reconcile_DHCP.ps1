function Reconcile_DHCP{
    param()

    Reconcile-DhcpServerv4IPRecord -ScopeId (Get-DhcpServerv4Scope ).ScopeId -ComputerName sisyphus -Confirm:$false -Force

    $Leases = Get-DhcpServerv4Lease -ScopeId (Get-DhcpServerv4Scope ).ScopeId

    foreach ($Lease in $Leases)
    {
        if (($lease).IPAddress -eq  ($lease).HostName)
        {
            $lease | Remove-DhcpServerv4Lease 
        }
    }
}