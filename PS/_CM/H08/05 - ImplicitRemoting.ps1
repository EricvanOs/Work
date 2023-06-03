# 1
$dc = New-PSSession sisyphus

# 2
Get-Module -PSSession $dc -ListAvailable

# 3
Import-Module -PSSession $dc -Name DhcpServer -Prefix Rem  # mag ook zonder Prefix

# 4
Get-Module
Get-Module -Name DhcpServer | Select-Object -ExpandProperty ExportedCommands


Get-RemDhcpServerv4Lease -ScopeId 192.168.82.0

Get-ChildItem -Path c:\Work   # Lokaal !!

# 5
$dc | Remove-PSSession
Get-PSSession -ComputerName sisyphus | Remove-PSSession

# 6
Get-RemDhcpServerv4Lease -ScopeId 192.168.82.0  # recreates the session



# implicit remoting naar exchange 2016


$cred = Get-Credential
$Ses = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://iris.pantheon.somewhere/PowerShell/ -Authentication Kerberos -Credential $Cred

Import-PSSession $Ses

Get-Mailbox 

#list all command from module
$MName = (Get-Module -Name tmp*.*).Name
Get-Command -Module $MName

#cleanup
Remove-PSSession $Ses



