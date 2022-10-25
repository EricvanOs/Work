Param (
    [string]$ComputerName,
    [int]$EventID
)

Write-Host "The value of `$ComputerName is: $ComputerName" #notice that backtick is used
Write-Host "The value of `$EventID is: $EventID"


# test
<#
Set-Location -Path C:\Work\PS\_CM\H07B
#>