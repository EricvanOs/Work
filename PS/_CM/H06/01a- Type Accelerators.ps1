$AcceleratorType = [psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")
$AcceleratorType::Get 

# ipddress / ipendpoint
[ipaddress] '192.168.8.102'
[IPEndpoint] '192.168.8.102:3389' 


# MAC Address
[PhysicalAddress]'48-51-b7-34-a0-cb'
[PhysicalAddress]'48:51:b7:34:a0:cb'
[PhysicalAddress]'4851B734A0CB'


# email address
[mailaddress] 'pietje@here.com'
[mailaddress] '"John, Doe" <JDoe@abc.com>'


# Active Directory Service Interface
[adsi] 'LDAP://cn=Jim de Jong,ou=bekenden,dc=pantheon,DC=somewhere' # LDAP met hoofdletters
([adsisearcher]'samaccountname=JdeJong').FindOne()
([adsisearcher]'givenname=eric').FindAll()


# culture/locales
[cultureinfo]::CurrentCulture = 'nl-NL'; 1.2
[cultureinfo]::CurrentCulture = 'th-TH'; Get-Date 


# guid
[guid] (New-Guid) 


# PSCredential
$password = ConvertTo-SecureString 'Password@123' -AsPlainText -Force
New-Object System.Management.Automation.PSCredential ('Administrator', $password)
# Alternatively create credentials using the type accelerator
[PSCredential]::new('Adminstrator', $password)

#URI
[uri] "https://4sysops.com/archives/managing-disks-with-powershell/"


# [TimeSpan]::New(days, hours, minutes, seconds)
$ts = [TimeSpan]::New(1, 7, 5, 59)
(Get-Date).AddHours($ts.TotalHours)

#find methods of static class 
[timespan] | Get-Member -Static

# void suppress all output
$array = New-Object System.Collections.ArrayList
$array.Add(1)
$array.Add(2)
[void] $array.Add(3)

#version
[version]'1.5.7.3'


#Scriptblock
[scriptblock]$block = {
    Import-Module ServerManager
    Get-WindowsFeature | Where-object { $_.Installed } |
    Select-object Name,DisplayName,Description 
}

Invoke-Command -ScriptBlock $block

