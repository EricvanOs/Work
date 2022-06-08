Get-ADUser -Filter '*'
Get-ADUser -Filter *

get-help about_ActiveDirectory_Filter -Online

Get-ADObject -Filter ' ObjectClass -eq "computer" '   # ' en "
Get-ADObject -Filter " ObjectClass -eq 'computer' "   # " en '

Get-ADObject -Filter '(CN -like "er*" -or CN -eq "administrator" )'

# ook mogelijk via LDAPFilter
Get-ADObject -LDAPFilter  '(cn=er*)'
Get-ADObject -LDAPFilter  "(cn=er*)"


# beide filters mag niet (zie MSDN)
Get-ADObject -LDAPFilter '(cn=er*)' -Filter 'Name -like "*us"'

