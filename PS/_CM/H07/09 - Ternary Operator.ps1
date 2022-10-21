# ternary operator
$valueA = 50
$valueB = 100
# Using simple then/else statements
$valueA -gt $valueB ? "$valueA is greater than $valueB." : "$valueA is less than $valueB."
# Using complex then/else statements
($valueA -gt $valueB) ? (Write-Host "$valueA is greater than $valueB.") : (Write-Host "$valueA is less than $valueB.")

# use cases
# Stopping services
$service = Get-Service -Name 'Spooler'
$service.Status -eq 'Running' ? (Stop-Service -Name 'Spooler') : 'Service not started'

# testing file path
(Test-Path -Path 'C:\logFiles') ? 'Directory already exists' : (New-Item -Path 'C:\logFiles' -ItemType Directory)