# install-module -name dbatools

Get-Command -Module dbatools

#eg

Get-DbaAgentJob -SqlInstance eos 

Get-DbaLogin -SqlInstance eos

Get-DbaDatabase -SqlInstance clio

Test-DbaLastBackup -SqlInstance clio -Database Ipam_DB

##
Test-DbaDiskAlignment -ComputerName eos | Select-Object -Property Name, IsBestPractice

Test-DbaSpn -ComputerName eos

Test-DbaDiskSpeed -SqlInstance clio | Where-Object{$_.ReadPerformance -ne 'Very Good' -or $_.WritePerformance -ne 'Very Good'}