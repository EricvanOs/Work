#remove trivial addresses
$conns = Get-NetTCPConnection | Where-Object{$_.LocalAddress -ne '::' -and $_.LocalAddress -ne '0.0.0.0' -and $_.LocalAddress -ne '127.0.0.1'} 

#remove internal addresses
$conns = $conns | Where-Object{$_.RemoteAddress -notlike '192.168.82.*'}

#remove to nntp xs4all.nl
$conns = $conns |Where-Object{$_.RemoteAddress -notlike '194.109.*.*' -or $_.RemotePort -ne '119'}

$conns
