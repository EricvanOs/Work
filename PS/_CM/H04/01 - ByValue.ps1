# 1
Get-Service -Name BITS | Stop-Service -WhatIf

# 2
Get-Service | Get-Member

# 3
Get-Help Stop-Service -ShowWindow  # inputObject <ServiceController[]> ; ByValue

# 4 
Get-Help Select-Object -ShowWindow  #inputObject <PSObject> ; ByValue (maw elk object)