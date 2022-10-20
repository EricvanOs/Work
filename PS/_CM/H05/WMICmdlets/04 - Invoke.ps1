
#4 mag ook middels WMI, let op syntax verschillen. Powershell 7 werkt niet alles meer

Invoke-WmiMethod -ComputerName Sisyphus -Class Win32_OperatingSystem -Name reboot  -WhatIf
Invoke-WmiMethod -ComputerName Electra  -Class Win32_OperatingSystem -Name reboot  -WhatIf   # fout melding firewall WMI probleem

Start-Process -FilePath Mspaint -WindowStyle Hidden

# worked with PS 5.1 but not with  PS 7.0
Get-WmiObject -Class Win32_Process -Filter "Name='mspaint.exe'" | 
  Invoke-WmiMethod -Name Terminate -WhatIf


