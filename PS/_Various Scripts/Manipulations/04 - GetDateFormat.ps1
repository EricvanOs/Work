﻿#Common date-time format strings
Get-Date -Format "yyyy-MMM-dd-hhmmtt"

<#
Format pattern Explanation

tt     A.M./P.M. designator
ss     Seconds with leading zero
mm     Minutes with leading zero
dd     Day of the month with leading zero
dddd   Full name of the day of the week
hh     12 hour clock with leading zero
HH     24 hour clock with leading zero
MM     Numeric month with leading zero
MMM    Abbreviated month name
MMMM   Full month name
yy     Two digit year
yyyy   Four digit year
#>

Get-Date -Format 'd' 
Get-Date -Format 'dd' 
Get-Date -Format 'ddd' 
Get-Date -Format 'dddd' 

Get-Date -Format 'M' 
Get-Date -Format 'MM' 
Get-Date -Format 'MMM' 
Get-Date -Format 'MMMM' 

Get-Date -Format 'y' 
Get-Date -Format 'yy' 
Get-Date -Format 'yyy' 


Get-Date -Format 'hh' 

Get-Date -Format 'HH' 

# mag ook met UFormat 
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-6
Get-Date -UFormat '%Z'  
Get-Date -UFormat '%m'

Get-Date -UFormat '%s' 
Get-Date -UFormat '%S'  

