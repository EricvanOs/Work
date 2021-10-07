# 1
New-ADObject -Name JohnSmithcontact -Type contact -DisplayName "John Smith (Contoso.com)" -Path "ou=PSTest,dc=pantheon,dc=somewhere"

# 2
get-help Get-ADObject -Online
Get-ADObject -Filter ' ObjectClass -eq "contact" '
Get-ADObject -Filter ' ObjectClass -eq "group" '    
Get-ADObject -Filter " ObjectClass -eq 'group' "

#cleanup contact

Get-ADObject -Identity "CN=JohnSmithcontact,OU=PSTest,DC=pantheon,DC=somewhere" | Remove-ADObject -Confirm:$false


# 3
get-help New-ADUser -Online
New-ADUser -Name "PietjeP" -SamAccountName "PietjePuk" -GivenName "Piet" -Surname "Puk" -DisplayName "Pietje Puk" `
           -Path "OU=PSTest,DC=Pantheon,DC=somewhere" #name = commonname en backtick

Get-ADUser -Identity  "CN=PietjeP,OU=PSTest,DC=Pantheon,DC=somewhere"
Get-ADUser PietjePuk  #mag ook


Set-ADObject -Identity "CN=PietjeP,OU=PSTest,DC=Pantheon,DC=somewhere" -Description "Member of support team"

# 4
Get-ADUser PietjePuk -Properties Description

# 5
get-help New-ADGroup -Online
New-ADGroup -Name PSHelpdesk -SamAccountName PSHelpdesk -GroupCategory Security -GroupScope Global `
            -Path  "OU=PSTest,DC=Pantheon,DC=somewhere" -DisplayName PSHelpdesk

Rename-ADObject -Identity "CN=PSHelpdesk,OU=PSTest,DC=Pantheon,DC=somewhere" -NewName SupportTeam

# 6
Get-ADGroup PShelpdesk

Get-Help Set-ADGroup -Online

$group= Get-ADGroup -Identity PSHelpdesk
$group.Description = "Group for support team"
Set-ADGroup -Instance $group


#7 cleanup
Remove-ADGroup PShelpdesk -Confirm:$false
Remove-ADUser PietjePuk -Confirm:$false


 


