Get-Module -ListAvailable
Get-Command -Module ActiveDirectory

#inventaris
Get-ADForest
Get-ADDomain
Get-ADOrganizationalUnit -Filter "name -eq 'Sales'"
Get-ADOrganizationalUnit -Filter "*"
Get-ADGroup -Filter *
Get-ADUser -Filter *
Get-ADUser -Filter "name -like '*john*'"

#nieuwe AD objecten maken
help new-aduser -ShowWindow
New-ADOrganizationalUnit -Name Developers -Path "OU=IT,dc=adatum,dc=com" 
New-ADGroup -GroupCategory Security -GroupScope Universal -Name developers -Path "ou=developers,OU=IT,dc=adatum,dc=com"
New-ADUser -Name Darwin -City Antwerpen -Path "ou=developers,OU=IT,dc=adatum,dc=com" -Department IT

Add-ADGroupMember -Identity developers -Members "CN=darwin,ou=developers,OU=IT,dc=adatum,dc=com"
#securestring
New-ADUser -Name Willy -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd!" -AsPlainText -Force) -Enabled  $true

#aanpassen
Set-ADUser -Identity darwin -City Eindhoven

#nieuw contact
New-ADObject -Name Michael -Type contact  

#searchscope
Get-ADUser -Filter * -SearchBase "ou=IT,dc=adatum,dc=com" -SearchScope Subtree  #|select distinguishedname


#grouppolicies
Get-Command -Module GroupPolicy
Get-GPO -All
new-gpo -Name DarwinGPO 
Set-GPRegistryValue -Key HKLM\SOFTWARE\Microsoft/Darwin -ValueName myvalue `
     -Value 13245 -Type DWord -Name darwinGPO
New-GPLink -Name darwinGPO -Target "ou=developers,OU=IT,dc=adatum,dc=com" -LinkEnabled Yes 

Get-GPOReport -Name darwinGPO -ReportType Html -Path c:\darwinGPO.html
ii -Path C:\darwinGPO.html
Backup-GPO -Name darwinGPO -Path c:\



#serverManager
Get-Command -Module servermanager
Get-WindowsFeature -ComputerName lon-dc1
Install-WindowsFeature -ComputerName lon-dc1 -Name web-server  -IncludeAllSubFeature
Get-WindowsFeature -Name web-* -ComputerName lon-dc1

#optionalfeature
Get-WindowsOptionalFeature -Online #locale OS
Enable-WindowsOptionalFeature -FeatureName Tiffifilter -Online


#IIS cmdlets
Get-Command -Module webad





















