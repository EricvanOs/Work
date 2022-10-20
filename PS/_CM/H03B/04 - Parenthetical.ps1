# create user and group
New-ADUser -SamAccountName 'PietjePuk' -GivenName 'Piet' -Surname 'Puk' -DisplayName 'Pietje Puk' `
           -Path 'OU=PSTest,DC=Pantheon,DC=somewhere' -name 'PietjeP' -City 'London'

New-ADGroup -Name PSHelpdesk -SamAccountName PSHelpdesk -GroupCategory Security -GroupScope Global `
            -Path  'OU=PSTest,DC=Pantheon,DC=somewhere' -DisplayName PSHelpdesk

# 
Get-ADGroup 'PSHelpdesk' | Add-ADGroupMember  # welke users toevoegen ?

# 
Get-ADGroup 'PSHelpdesk' | Add-ADGroupMember -Members (Get-ADUser -Filter {City -eq 'London'})

# 
Get-ADGroupMember 'PSHelpdesk'

# kan ook als volgt
$LU = Get-ADUser -Filter {City -eq 'London'}
$grp = Get-ADGroup 'PSHelpdesk' 
Add-ADGroupMember -Identity $grp -Members $LU 


# cleanup
Remove-ADGroup PSHelpdesk -Confirm:$false
Remove-ADUser PietjePuk -Confirm:$false