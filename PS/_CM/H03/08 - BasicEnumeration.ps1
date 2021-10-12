# 1
Get-Service | ForEach Name

get-alias foreach

get-service | ForEach-Object name   # netter


Get-EventLog -List | Get-Member  #clear is a method

Get-EventLog -List | Where Log -ne 'System' | ForEach Clear -WhatIf

Get-EventLog -List | Where-Object Log -ne 'System' | ForEach-Object Clear -WhatIf  # netter

Get-EventLog -List | Where-Object{$_.Log -ne 'System'} | ForEach-Object -MemberName Clear -WhatIf

# parenthetical solution
(Get-EventLog -List |  Where-Object{$_.Log -ne 'System'}).Clear()  # whatif doesn't work now

# another solution
Clear-EventLog -LogName (Get-EventLog -List | Where-Object{$_.Log -ne 'System'}).Log -WhatIf


Invoke-Expression -Command "notepad.exe" # 2* doen

Get-Process | Get-Member  #Kill is a method
 
Get-Process | where ProcessName -eq 'notepad' | ForEach Kill -WhatIf

# more clear
Get-Process | Where-Object ProcessName -eq 'notepad' | ForEach-Object Kill -WhatIf

# parenthetical solution
(Get-Process | Where-Object ProcessName -eq 'notepad' ).Kill()  # whatif doesn't work now

# another solution(s)
Get-Process | Where-Object ProcessName -eq 'notepad' | Stop-Process -WhatIf
Stop-Process -Name notepad -WhatIf
Stop-Process -ID (Get-Process | Where-Object{$_.name -eq 'notepad'} ).id  -WhatIf

