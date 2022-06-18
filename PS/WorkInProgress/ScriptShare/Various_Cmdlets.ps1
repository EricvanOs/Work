get-process | measure-object -property workingset -minimum -maximum -average

Test-Path -Path "C:\Documents and Settings\NicoleH"


'C:\windows\*' | resolve-path

Resolve-Path 'c:\program files*\' 

Start-Sleep -s 4  

get-service | out-null

$Command = 'Get-Process | where {$_.cpu -gt 10}'
Invoke-Expression $Command  # liever niet gebruiken vanwege injection attacks

$processes_before = get-process
notepad
$processes_after  = get-process
compare-object -referenceobject $processes_before -differenceobject $processes_after


