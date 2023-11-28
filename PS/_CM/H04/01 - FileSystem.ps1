# 2
Set-Location -Path C:\

# 3
New-PSDrive -Name NEWDIR -Root C:\Windows -PSProvider FileSystem
Get-PSDrive

# 4
Set-Location NEWDIR:

#5
Get-ChildItem NEWDIR:

# cleanup
Set-Location -Path C:\Work\PS\

Remove-PSDrive  NEWDIR
Get-PSDrive

