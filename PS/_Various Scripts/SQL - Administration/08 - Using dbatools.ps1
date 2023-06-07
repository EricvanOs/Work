# install-module -name dbatools

Get-Command -Module dbatools

#eg

Get-DbaAgentJob -SqlInstance clio.pantheon.somewhere 

Get-DbaLogin -SqlInstance clio.pantheon.somewhere

Get-DbaDatabase -SqlInstance clio.pantheon.somewhere

Test-DbaLastBackup -SqlInstance clio.pantheon.somewhere -Database Ipam_DB

##
Test-DbaDiskAlignment -ComputerName clio.pantheon.somewhere | Select-Object -Property Name, IsBestPractice

Test-DbaSpn -ComputerName clio.pantheon.somewhere

Test-DbaDiskSpeed -SqlInstance clio.pantheon.somewhere | Where-Object{$_.ReadPerformance -ne 'Very Good' -or $_.WritePerformance -ne 'Very Good'}