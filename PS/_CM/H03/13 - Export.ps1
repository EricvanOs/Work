New-ADUser -Name 'PietjeP' -SamAccountName 'PietjePuk' -GivenName 'Piet' -Surname 'Puk' -DisplayName 'Pietje Puk' `
           -Path 'CN=Users,DC=Pantheon,DC=somewhere'

Get-ADUser -Identity  'CN=PietjeP,CN=Users,DC=Pantheon,DC=somewhere' | Export-Csv -NoTypeInformation  -Path k:\outad.csv

Remove-ADUser PietjePuk -Confirm:$false

Get-ADUser -Filter "Name -eq 'PietjeP'"

# pas outad-file aan naar wens, letop parameter passing byPropertyName
Import-Csv -Path K:\outad.csv | New-ADUser

Get-ADUser -Filter "Name -eq 'PietjeP'"

Remove-ADUser PietjePuk -Confirm:$false

Get-ChildItem -Path K:\outad.csv | Remove-Item


