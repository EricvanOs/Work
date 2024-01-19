<#
Passing references to .NET methods
Some .NET methods may require you to pass a variable as a reference. 
When the method's definition uses the keywords in, out, or ref on a parameter, it expects a reference.
#>

[int] | Get-Member -Static -Name TryParse

#example
$number = 7
[int]::TryParse("15", ([ref]$number))
$number

[int]::TryParse("AB", ([ref]$number))
$number