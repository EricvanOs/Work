# 1
Set-Location HKLM:\Software

# 2
Get-ChildItem

# 3
New-Item -Name Demo

# 4
New-ItemProperty -path HKLM:\Software\Demo -Name Demo -Value Test -PropertyType String

#5
Get-ItemProperty -Path Demo


#6 cleanup

Remove-Item -Path HKLM:\Software\Demo