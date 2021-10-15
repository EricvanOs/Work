New-ADUser -Name 'PietjeP' -SamAccountName 'PietjePuk' -GivenName 'Piet' -Surname 'Puk' -DisplayName 'Pietje Puk' `
           -Path 'OU=PSTest,DC=Pantheon,DC=somewhere'

Get-ADUser -Identity  'CN=PietjeP,OU=PSTest,DC=Pantheon,DC=somewhere' | Export-Csv -NoTypeInformation  -Path k:\outad.csv
Remove-ADUser PietjePuk -Confirm:$false

# pas outad-file aan --> eerste kolom naar path en entry aanpassen
Import-Csv -Path K:\outad.csv | New-ADUser

Remove-ADUser PietjePuk -Confirm:$false

Get-ChildItem -Path K:\outad.csv | Remove-Item

