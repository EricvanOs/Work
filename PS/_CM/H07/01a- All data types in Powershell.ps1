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