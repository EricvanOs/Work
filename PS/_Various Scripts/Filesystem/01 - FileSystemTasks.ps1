# Resolve Path
 
 Set-Location -Path C:\Work\PS\_CM
 
 Resolve-Path .\test.txt 

 Split-Path -Path 'C:\Work\PS\_CM\test.txt' -Leaf

 Join-Path -Path 'C:\Work\PS\_CM' -ChildPath test.txt

 Test-Path -Path K:\abc

 Convert-Path .

# Discovering File System-related Cmdlets

Get-Command -Noun item*, path 

