Set-Location -Path C:\Work\PS\Temp

# use module NTFSSecurity for manipulating NTFS-Rights

get-module -Name *ntf* -ListAvailable

Get-Command -Module NTFSSecurity


$path = '.\NTFS-Test'

$files = Get-ChildItem -Path $path

foreach ($file in $files){}

Get-NTFSAccess -Path $file
