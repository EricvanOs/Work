Param (
    [string]$ComputerName,
    [int]$EventID
)

Write-Host "The value of `$ComputerName is: $ComputerName" #notice that backtick is used
Write-Host "The value of `$EventID is: $EventID"


# test
New-PSDrive -Name K -Root C:\Work\PS -PSProvider FileSystem  

set-location K:\_CM\H09

# cleanup
Remove-PSDrive K