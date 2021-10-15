#Use Read-Host to obtain user input
$days = Read-Host 'Enter the number of days'
$days

#Use Get-Credential to obtain and store a credential
$cred = Get-Credential
$cred | Format-List
$cred | Export-Clixml -Path K:\_CM\cred.xml
Get-Content K:\_CM\cred.xml

# using credentials again (on this machine and user)
$cred = Import-Clixml -Path K:\_CM\cred.xml 

# retrieve password
$cred.GetNetworkCredential().password

# example
Enter-PSSession -ComputerName sisyphus -Credential (Get-Credential)
Exit-PSSession


#Use Out-Gridview to obtain a user selection
Get-ADComputer -Filter * | Out-GridView
$computer = Get-ADComputer -Filter * | Out-GridView -OutputMode Multiple   # click somewhere & ok
$computer

