# 1
Get-ADComputer -Filter * | Get-Process   # gaat fout 

# 2
Get-ADComputer -Filter * | Get-Member

# 3
Get-Help Get-Process -ShowWindow  # ByPropertyName  -- ComputerName ,Id, Name

# 4
Start-Process -FilePath Notepad -WindowStyle Hidden

get-process | Where-Object{$_.Name -eq 'notepad'}

Get-Process -ComputerName localhost | Where-Object{$_.Name -eq 'notepad'}

Get-Process -Name notepad

Get-Process -id 3020

# maw een computername , name of id als input voor get-process


Get-ADComputer -Filter("Name -like 'hy*a*' ") | 
  Select-Object -Property @{n='ComputerName';e={$_.Name}} | 
  Get-Process
