# 2
Set-Location -Path C:\Windows

# 3
New-PSDrive -Name WINDIR -Root C:\Windows -PSProvider FileSystem
Get-PSDrive

# 4
Set-Location WINDIR:

#5
Get-ChildItem WINDIR:

#6
New-Item C:\Work\PS\TempX -ItemType Directory

#7 cleanup

Remove-Item -Path C:\Work\PS\TempX

Set-Location -Path C:\Work\PS\

Remove-PSDrive  WINDIR
Get-PSDrive

