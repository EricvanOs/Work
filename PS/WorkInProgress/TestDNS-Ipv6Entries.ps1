$computers = get-adcomputer -Filter * -SearchBase 'OU=Servers,DC=Pantheon,DC=Somewhere' | Select-Object -ExpandProperty name
$computers += get-adcomputer -Filter * -SearchBase 'OU=Domain Controllers,DC=Pantheon,DC=Somewhere' | Select-Object -ExpandProperty name

$ProgressPreference = 'SilentlyContinue'
foreach($computer in $computers){

    if ((Test-NetConnection -computername $computer -WarningAction Ignore).PingSucceeded -eq $false){continue}

    $ipconfig = Invoke-Command -ComputerName $computer -ScriptBlock {Get-NetIPConfiguration}

    $dnsservers = $ipconfig.DNSServer.ServerAddresses
    foreach ($dnsserver in $dnsservers){
        if($dnsserver -match '192\.168\.82') {continue}
        if($dnsserver -match 'fd00') {continue}

        write-host  $computer    [ipaddress]$dnsserver    
    }   
    

}
$ProgressPreference = 'Continue'



$computers = get-adcomputer -Filter * -SearchBase 'OU=Servers,DC=Pantheon,DC=Somewhere' | Select-Object -ExpandProperty name
$computers += get-adcomputer -Filter * -SearchBase 'OU=Domain Controllers,DC=Pantheon,DC=Somewhere' | Select-Object -ExpandProperty name

$ProgressPreference = 'SilentlyContinue'
foreach($computer in $computers){

    if ((Test-NetConnection -computername $computer -WarningAction Ignore).PingSucceeded -eq $false){continue}

    $ipconfig = Invoke-Command -ComputerName $computer -ScriptBlock {Get-NetIPConfiguration}

    $ipv6s = $ipconfig.IPv6Address.IpAddress 
    foreach ($ipv6 in $ipv6s){
        if($ipv6 -match 'fd00') {continue}
        if($ipv6 -match '2a02') {continue}

        write-host  $computer    [ipaddress]$ipv6  
    }   
    

}
$ProgressPreference = 'Continue'



