Push-Location Cert:\LocalMachine\My

Get-ChildItem -recurse |
Where-Object {$_.NotAfter -lt (Get-Date).Date} | 
Where-Object{$_.Issuer -like 'CN=pantheon-MORPHEUS-CA*'} | 
Remove-Item -WhatIf

Pop-Location 


<# Just to test 
Push-Location Cert:\LocalMachine\My

Get-ChildItem -recurse |
Where-Object {$_.NotAfter -lt [datetime]'2027-12-13'} | 
Where-Object{$_.Issuer -like 'CN=pantheon-MORPHEUS-CA*'} | 
Remove-Item -WhatIf

Pop-Location 
#>