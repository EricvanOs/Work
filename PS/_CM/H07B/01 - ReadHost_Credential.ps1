Set-Location -Path 'C:\Work\PS\_CM'

#Use Read-Host to obtain user input
$days = Read-Host 'Enter the number of days'
$days

#Use Get-Credential to obtain and store a credential
$cred = Get-Credential
$cred | Format-List
$cred | Export-Clixml -Path .\cred.xml 
Get-Content .\cred.xml

# using credentials again (on this machine and user)
$cred = Import-Clixml -Path .\cred.xml 

#using on cerberus
Copy-Item -Path .\cred.xml -Destination '\\cerberus\c$\temp\cred.xml'
Remove-Item -Path '\\cerberus\c$\temp\cred.xml'

# retrieve password
$cred.GetNetworkCredential().password 

# example
Enter-PSSession -ComputerName sisyphus -Credential (Get-Credential)
Exit-PSSession


#Use Out-Gridview to obtain a user selection
Get-ADComputer -Filter * | Out-GridView
$computer = Get-ADComputer -Filter * | Out-GridView -OutputMode Multiple   # click somewhere & ok
$computer

#  variations
$Credential = $host.ui.PromptForCredential("Need credentials", "Please enter your user name and password.", "", "NetBiosUserName")
$Credential

$User = "Domain01\User01"
$PWord = ConvertTo-SecureString -String "P@sSwOrd" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
$Credential

Get-Credential -Message "Credential are required for access to the \\Server1\Scripts file share." -User Server01\PowerUser

