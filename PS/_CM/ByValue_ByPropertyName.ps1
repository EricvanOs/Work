# start notepad
notepad

Get-Process -Name notepad | Stop-Process -Name notepad   #fails

# verschillende opties

Get-Process -Name notepad | Stop-Process -WhatIf #ByValue

$proc = Get-Process -Name notepad
Stop-Process -Name $proc -WhatIf  # lukt niet, kijk naar help

get-help Stop-Process -ShowWindow 

# -id en -name (ByPropertyValue) of -inputObject (ByValue)

Stop-Process -InputObject $proc -WhatIf

# of
$proc.Name
$proc.Id

Stop-Process -Name $proc.Name -WhatIf
Stop-Process -id $proc.Id -WhatIf

Stop-Process -name ($proc | Select-Object -Property  name) -WhatIf # lukt niet, want nog steeds een object
Stop-Process -name ($proc | Select-Object -ExpandProperty  name) -WhatIf


#of

$proc.name | Stop-Process -WhatIf  # lukt niet

# dit wel

$proc | Select-Object -Property name | Stop-Process -WhatIf

$proc | Select-Object -Property id | Stop-Process -WhatIf

$proc | Stop-Process -WhatIf  #ByValue

# dit mag ook

$proc | Select-Object -Property name,handles | Stop-Process -WhatIf

$proc | Select-Object @{Name="id";Expression={7044}} | Stop-Process -WhatIf  # doet 't wel, maar is een beetje vreemd

