# ternary operator
$valueA = 50
$valueB = 100
# Using simple then/else statements
$valueA -eq $valueB ? "$valueA is equal to $valueB." : "$valueA is not equal to $valueB."


# use cases
# Stopping services
$service = Get-Service -Name 'Spooler'
$service.Status -eq 'Running' ? (Stop-Service -Name 'Spooler') : 'Service not started'

# testing file path
(Test-Path -Path 'C:\logFiles') ? 'Directory already exists' : (New-Item -Path 'C:\logFiles' -ItemType Directory)