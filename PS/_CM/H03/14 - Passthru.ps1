# geen informatie in $notepad
$notepad = Start-Process notepad

# nu wel
$notepad = Start-Process notepad –PassThru

$notepad.StartTime

$notepad | Stop-Process


# set of command which have PassThru as parameter
Get-Command -CommandType 8 | Where-Object {$_.definition -match 'passthru'}