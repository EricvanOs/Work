New-PSDrive -Name K -Root C:\Work\PS\Temp -PSProvider FileSystem

Set-Location k:\

# all different information about an item

 Get-Item $env:windir\explorer.exe | Select-Object *

 # List directories only:
Get-ChildItem | Where-Object { $_ -is [System.IO.DirectoryInfo] }
Get-ChildItem | Where-Object { $_.PSIsContainer }
Get-ChildItem | Where-Object { $_.Mode -like 'd*' }

# List files only:
Get-ChildItem | Where-Object { $_ -is [System.IO.FileInfo] }
Get-ChildItem | Where-Object { $_.PSIsContainer -eq $false}
Get-ChildItem | Where-Object { $_.Mode -notlike 'd*' }

# files created after 2011-05-12
Get-ChildItem $env:windir | Where-Object { $_.CreationTime -gt [datetime]::Parse("May 12, 2011") }

# files that have been changed in the last two weeks
Get-ChildItem $env:windir | Where-Object { $_.CreationTime -gt (Get-Date).AddDays(-14) }

# list of system folders known by GetFolderPath()
[System.Environment+SpecialFolder] | Get-Member -Static -MemberType Property

# list of all system folders covered plus their actual paths:
[System.Environment+SpecialFolder] | Get-Member -Static -MemberType Property |
ForEach-Object {"{0,-25}= {1}" -f $_.name, [Environment]::GetFolderPath($_.Name) }

# maps drives to all important file locations.
Function Map-Profiles {
 [System.Environment+SpecialFolder] | Get-Member -Static -MemberType Property | 
  ForEach-Object {
    New-PSDrive -Name $_.Name -PSProvider FileSystem -Root ([Environment]::GetFolderPath($_.Name)) -Scope Global
  }
}
Map-Profiles

#  Get rid of cookies
Get-ChildItem cookies:
Get-ChildItem cookies: | Remove-Item  -Recurse -WhatIf

# get all "drives"
Get-PSDrive

# make use of .NET
[IO.Path]::GetDirectoryName('K:\MyTranscript.txt')

# list of all methods in [IO.Path]
[IO.Path] | Get-Member  -MemberType method  -Static # don't forget -static option

# Methods and property of [IO.Path]
[IO.Path] | Get-Member -Static

# cleanup
Set-Location -Path C:\
Remove-PSDrive K