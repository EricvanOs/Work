if ( Get-Process Notepad ){write-host 'Notepad running'}

if ( Get-Process | Where-Object Name -eq Notepad ){write-host 'Notepad running'}

# if no notepad is running
Get-Process Notepad  # will give an error
Get-Process | Where-Object Name -eq Notepad # will give empty result set

#stop all notepads
if ( $process = Get-Process Notepad* )
{
    $process | Stop-Process
}