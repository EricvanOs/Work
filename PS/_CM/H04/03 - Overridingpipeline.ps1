Start-Process -FilePath notepad -WindowStyle Hidden

Get-Process -Name Notepad | Stop-Process

# 2
Start-Process -FilePath notepad -WindowStyle Hidden

Get-Process -Name Notepad | Stop-Process -Name notepad   #gaat fout

