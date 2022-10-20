Param(
    [string]$Path=(Read-Host "Enter a folder path"),
    [switch]$Recurse
) #end Param

#Query files in the path specified
$files=Get-ChildItem -Path $Path -File -Recurse:$Recurse -ErrorAction SilentlyContinue

#Calculate total file size
$size = 0
$sizeMB = 0

Foreach ($file in $files) {
    $size += $file.length
} # end ForEach
[int]$sizeMB = $size/1MB

#Display file information 
Write-Host "In $Path there are $($files.count) files"
If ($Recurse -eq $true) {
    Write-Host "Subfolders are included"
}
Write-Host "Total file size is $sizeMB MB"

<#
# test
New-PSDrive -Name K -Root C:\Work\PS -PSProvider FileSystem  

Set-Location -Path  K:\_cm\H09

# & '.\07 - ReadFolderStructure.ps1' -Path c:\tools_ssas
# & '.\07 - ReadFolderStructure.ps1' -Path c:\tools_ssas -Recurse
# & '.\07 - ReadFolderStructure.ps1' -Path c:\tools_ssas -Recurse:$true

# cleanup
Remove-PSDrive K
#>