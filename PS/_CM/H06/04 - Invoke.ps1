# 1
Invoke-CimMethod -ComputerName Electra -ClassName Win32_OperatingSystem -MethodName Reboot -WhatIf

# 2
Start-Process -FilePath Mspaint -WindowStyle Hidden

# 3
Get-CimInstance -Class Win32_Process -Filter "Name='mspaint.exe'" | 
  Invoke-CimMethod -Name Terminate -WhatIf


#4 mag ook middels WMI, let op syntax verschillen

Invoke-WmiMethod -ComputerName Sisyphus -Class Win32_OperatingSystem -Name reboot  -WhatIf
Invoke-WmiMethod -ComputerName Electra  -Class Win32_OperatingSystem -Name reboot  -WhatIf   # fout melding firewall WMI probleem

Start-Process -FilePath Mspaint -WindowStyle Hidden

Get-WmiObject -Class Win32_Process -Filter "Name='mspaint.exe'" | 
  Invoke-WmiMethod -Name Terminate -WhatIf


