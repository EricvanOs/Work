# 1 
New-ADGroup -Name PSHelpDesk -Path "ou=PSTest,dc=pantheon,dc=somewhere" -GroupScope Global

# 2
New-ADUser -Name "Jane Doe" -Department "IT" -Path "ou=PSTest,dc=pantheon,dc=somewhere"

# 3
Add-ADGroupMember "PSHelpDesk" -Members "Jane Doe"

# 4
Set-ADuser "Jane Doe" -StreetAddress "1530 Nowhere Ave." -City "Winnipeg" -State "Manitoba" -Country "CA"

# 5
Get-ADPrincipalGroupMembership "Jane Doe"

# extra "ldap" properties via parameter (Properties)
Get-ADuser "Jane Doe" -Properties StreetAddress,City,State,Country
# compare with
Get-ADuser "Jane Doe" | Select-Object -Property *


#cleanup
Get-ADUser "Jane Doe" | Remove-ADUser -Confirm:$false
Get-ADGroup -Identity "CN=PSHelpDesk,ou=PSTest,dc=pantheon,dc=somewhere" | Remove-ADGroup -Confirm:$false
