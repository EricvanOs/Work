function Cleanup-Cbz {
<#
.SYNOPSIS
Cleanup of cbz-files.
.DESCRIPTION
Cleanup of cbz-files.
.PARAMETER Path
The path name where to find cbz-files. Default = \\aphrodite\_ToTestAgainstHashDB
.EXAMPLE
.\Cleanup-Cbz -Path 'C:\temp' 
#>
[CmdletBinding()]
Param(
    [Parameter()]
    [string]
    $Path = '\\aphrodite\_ToTestAgainstHashDB'
)

#set alias to command line version of 7zip
set-alias zip 'C:\Program Files\7-Zip\7z.exe'

Set-Location $Path

$files = get-childitem -Path $Path  -recurse -include *.cbz -File

foreach($file in $files){
    
    $filezip = ($file.basename + '.zip') 
    $filecbz = ($file.basename + '.cbz') 


    #rename the cbz file to zip	
    Rename-Item  $filecbz $filezip 

    #unzip the zip-file to a "temp" directory
	zip e -oztempz  -y $filezip 

    #delete previous zip-file	
    Remove-Item $filezip -Force

	#create temporary dir
	new-item -type directory -path .\ztmpz

	#move jpg,jpeg,gif,png files
	move-item -path .\ztempz\*.jpg  -destination .\ztmpz -Force
	move-item -path .\ztempz\*.jpeg -destination .\ztmpz -Force
 	move-item -path .\ztempz\*.gif  -destination .\ztmpz -Force
	move-item -path .\ztempz\*.png  -destination .\ztmpz -Force

	
	#create new zip-file
	zip a -mx=0 $filezip .\ztmpz\*

    #rename zip to cbz
	rename-item $filezip $filecbz
	
	
	#remove tmp and temp folder
	remove-item  'ztempz' -Recurse -Force
	remove-item  'ztmpz'  -Recurse -Force
 }   
    
    
set-location $Path

#remove 7zip alias
remove-item alias:zip

}

