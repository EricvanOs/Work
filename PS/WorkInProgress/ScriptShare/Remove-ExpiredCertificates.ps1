Push-Location Cert:\LocalMachine

$ctf = Get-ChildItem -recurse 

$now = get-date

$ctf | where-object {$_.NotAfter -lt $now} | Where-Object{$_.Issuer -like 'CN=pantheon-MORPHEUS-CA*'} | Remove-Item -WhatIf

Pop-Location 



