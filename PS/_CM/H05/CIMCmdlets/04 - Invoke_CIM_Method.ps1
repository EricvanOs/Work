# 1
Invoke-CimMethod -ComputerName Electra -ClassName Win32_OperatingSystem -MethodName Reboot -WhatIf

# 2
Start-Process -FilePath Mspaint -WindowStyle Hidden

# 3
Get-CimInstance -Class Win32_Process -Filter "Name='mspaint.exe'" | 
  Invoke-CimMethod -Name Terminate -WhatIf





