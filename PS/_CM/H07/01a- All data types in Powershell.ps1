$AcceleratorType = [psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")
$AcceleratorType::Get 



# examples

$ip = [ipaddress] '192.168.8.102'
$ip

$mail = [mailaddress] 'pietje@here.com'
$mail

[mailaddress] $mail2 = '"John, Doe" <JDoe@abc.com>'
$mail2

[adsi] $Account = 'LDAP://cn=Jim de Jong,ou=bekenden,dc=pantheon,DC=somewhere' # LDAP met hoofdletters
$Account

([adsisearcher]'samaccountname=JdeJong').FindOne()

([adsisearcher]'givenname=eric').FindAll()


# culture/locales
[cultureinfo]::CurrentCulture = 'nl-NL'; 1.2

[cultureinfo]::CurrentCulture = 'nl-NL'; Get-Date 

# guid
[guid]$a = New-Guid
$a

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

# void suppress all output
$array = New-Object System.Collections.ArrayList
$array.Add(1)
$array.Add(2)
[void] $array.Add(3)

