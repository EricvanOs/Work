# In addition to classes, .NET Framework contains enumerations. 
# An enumeration is essentially a list of predefined values

[Security.Principal.WindowsIdentity]::GetCurrent()

([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent())


[Security.Principal.WindowsBuiltInRole] "Administrator"

([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator") 

([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "User") 

([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Guest") 