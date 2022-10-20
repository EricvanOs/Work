# 1
Get-Service -Name BITS | Stop-Service -WhatIf

# 1b
$a = Get-Service -Name BITS
Stop-Service -InputObject $a -WhatIf

# 2
Get-Service | Get-Member

# 3
Get-Help Stop-Service -Online  # inputObject <ServiceController[]> ; ByValue

# 4 
Get-Help Select-Object -Online  #inputObject <PSObject> ; ByValue (maw elk object)

# 4b
Get-Service -Name BITS | Select-Object -Property *
Get-Process -name MSDTC | Select-Object -Property *

Get-Command -Noun Object