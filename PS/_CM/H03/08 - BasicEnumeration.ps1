# 1
Get-Service | ForEach Name


get-alias foreach

get-service | ForEach-Object name   # netter

# 2
Get-EventLog -List | Get-Member  #clear is a method

Get-EventLog -List | Where Log -ne 'System' | ForEach Clear -WhatIf

Get-EventLog -List | Where-Object Log -ne 'System' | ForEach-Object Clear -WhatIf  # netter

Get-EventLog -List | Where-Object{$_.Log -ne 'System'} | ForEach-Object -MemberName Clear -WhatIf

# parenthetical solution
(Get-EventLog -List |  Where-Object{$_.Log -ne 'System'}).Clear()  # whatif doesn't work now

# another solution
Clear-EventLog -LogName (Get-EventLog -List | Where-Object{$_.Log -ne 'System'}).Log -WhatIf

 