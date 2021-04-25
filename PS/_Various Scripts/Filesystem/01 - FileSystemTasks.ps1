# Resolve Path
 
 Set-Location -Path K:\_CM
 
 Resolve-Path .\test.txt 

 Split-Path -Path 'K:\_CM\test.txt'

 Join-Path -Path 'K:\_CM' -ChildPath test.txt

 Test-Path -Path K:\abc

 Convert-Path .

# Discovering File System-related Cmdlets

Get-Command -Noun item*, path 

