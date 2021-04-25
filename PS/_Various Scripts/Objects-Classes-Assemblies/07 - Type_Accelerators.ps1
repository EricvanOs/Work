<#
PowerShell type accelerators are aliases for .NET classes or types
For example, when you use the type accelerator [int] to define an integer value
#>

 # example
 $password = ConvertTo-SecureString 'Password@123' -AsPlainText -Force
New-Object System.Management.Automation.PSCredential ('Administrator', $password)
# Alternatively create credentials using the type accelerator
[PSCredential]::new('Adminstrator', $password)

# Listing all type accelerators
[PSObject].Assembly.GetType('System.Management.Automation.TypeAccelerators')::Get

# examples

[IPAddress] '127.0.0.1'
[IPAddress] '127.0.0.300'
[IPAddress] '127.0.0.abcd'
'127.0.0.1' -as [IPAddress]
'127.0.0.abcd' -as [IPAddress]


[uri] "https://4sysops.com/archives/managing-disks-with-powershell/"


[datetime] '05-01-1991'
[datetime].FullName


# [TimeSpan]::New(days, hours, minutes, seconds)
$ts = [TimeSpan]::New(1, 7, 5, 59)
(Get-Date).AddHours($ts.TotalHours)

# The type accelerator [void] can suppress all of your console outputs:

$array = New-Object System.Collections.ArrayList
$array.Add(1)
$array.Add(2)
[void] $array.Add(3)



