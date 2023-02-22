New-PSDrive -Name K -Root C:\Work\PS\Temp -PSProvider FileSystem

Set-Location k:\

New-Item -Path k:\ -ItemType Directory -Name x1
New-Item -Path k:\ -ItemType Directory -Name x2


#adding files to folder with wildcard
New-Item -Path k:\x?\ -ItemType file -Name abc.txt

# additional test
$path = Get-Item -Path k:\x1\*  -Filter "*.txt" | Select-Object  @{n='Path';e={$_.DirectoryName}}

Remove-Item -Path K:\x1\abc.txt

$path | New-Item  -ItemType file -Name abc.txt 

Remove-Item -Path K:\x1\abc.txt

# change path, wildcard

($path.Path) = 'k:\x?\'

$path

$path | New-Item  -ItemType file -Name abc.txt


# cleanup
Remove-Item -Path 'k:\x1','k:\x2' -Recurse -Confirm:$false 

Set-Location -Path C:\
Remove-PSDrive K
