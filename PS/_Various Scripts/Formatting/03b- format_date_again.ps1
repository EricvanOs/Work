# https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings?view=netframework-4.8

#To display full date pattern with short time pattern
Get-Date -Format f

#To display full date pattern with long time pattern
Get-Date -Format F

#To display short date pattern
Get-Date -Format d

#To display long date pattern
Get-Date -Format D

#Year month pattern
Get-Date -Format Y

## Combining format characters
Get-Date -Format "dddd dd-MM-yyyy HH:mm K"

Get-Date -UFormat %A
Get-Date -UFormat %b
Get-Date -UFormat %B

Get-Date -UFormat "%d-%m-%Y %r %Z"

