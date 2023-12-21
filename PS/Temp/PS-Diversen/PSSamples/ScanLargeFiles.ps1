<#
.SYNOPSIS
    zoeken naar bestanden van een bepaalde grootte of groter
.DESCRIPTION
    je kan path, minsize en recurse ofgeven....
.PARAMETER path
    path moet drive of folder zijn
.PARAMETER minsize
    minsize van bestand  vb 10 , 100mb, 1GB
.EXAMPLE
    scanlargeFiles.ps1 -path c:\ -minsize 100MB -recurse

    zoekt alle bestanden groter dan 100 MB
.EXAMPLE
    scanlargeFiles.ps1 -path c:\ -minsize 100

    zoekt alle bestanden groter dan 100 MB, alleen in de root vd C:\ schijf
#>
[cmdletbinding()]
param([string]$path="c:\",[int]$minSize=100MB,[switch]$recurse,[bool]$fullname)
#origineel
#Get-ChildItem -Path c:\ -Recurse | Where-Object length -gt 100MB

if (Test-Path $path)
{
    if ($recurse)
    {
         if ($fullname -eq $true)
        {Get-ChildItem -Path $path -Recurse  | Where-Object length -gt $minSize | select fullname}
         else
        {Get-ChildItem -Path $path -Recurse | Where-Object length -gt $minSize }
    }
    
    else
    
    {
        if ($fullname -eq $true)
        {Get-ChildItem -Path $path | Where-Object length -gt $minSize|select Fullname}
        else
        {Get-ChildItem -Path $path | Where-Object length -gt $minSize}
    }
}
else
{
    Write-Host "$path bestaat niet...."
}