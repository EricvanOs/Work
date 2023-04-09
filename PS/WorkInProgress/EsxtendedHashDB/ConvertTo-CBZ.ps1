function ConvertTo-Cbz {
<#
.SYNOPSIS
Converts all cbr-files to cbz-files.
.DESCRIPTION
Converts all cbr-files to cbz-files.
.PARAMETER Path
The path name where to find cbr-files. Default = \\aphrodite\_ToTestAgainstHashDB
.PARAMETER MaxRelativeDifference
The maximum relative difference accepted between cbr-file and cbz-file. Default =  0.2
.EXAMPLE
.\ConvertTo-Cbz -Path 'C:\temp' -MaxRelativeDifference 0.1
#>
[CmdletBinding()]
Param(
    [Parameter()]
    [string]
    $Path = '\\aphrodite\_ToTestAgainstHashDB',

    [parameter()]
    [single]
    $MaxRelativeDifference = 0.2
)

#set alias to command line version of 7zip
set-alias zip 'C:\Program Files\7-Zip\7z.exe'

Set-Location $path

$files = get-childitem -Path $Path  -recurse -include *.cbr -File

foreach($file in $files){
    
    $StartSize = (get-item $file).length
    $filecbr = ($file.basename + '.cbr')
    $filerar = ($file.basename + '.rar') 
    $filezip = ($file.basename + '.zip') 
    $filecbz = ($file.basename + '.cbz') 


    #rename the cbr file to rar	
    Rename-Item  $filecbr $filerar 

    #unzip the rar-file to a "temp" directory
	zip e -oztempz  $filerar

	#create temporary dir
	new-item -type directory -path .\ztmpz

	#move jpg,jpeg,gif,png files
	move-item -path .\ztempz\*.jpg  -destination .\ztmpz
	move-item -path .\ztempz\*.jpeg -destination .\ztmpz
 	move-item -path .\ztempz\*.gif  -destination .\ztmpz
	move-item -path .\ztempz\*.png  -destination .\ztmpz

	set-location  -Path .\ztmpz
	$aa = get-childitem 
	 foreach($a in $aa){
		$Newname = $a.FullName
		$Newname = $Newname -replace '\[','a'
		$Newname = $Newname -replace '\]','b'
		if($Newname -ne $a.FullName){
			move-Item -LiteralPath $a -destination $Newname
		}
         }
		
	set-location ..
	
	#create new zip-file
	zip a -mx=0 $filezip .\ztmpz\*

	#rename zip to cbz
	rename-item $filezip $filecbz
	
	$endsize = (get-item ($filecbz)).length
	$RelativeDifference = [math]::abs(($startsize - $endsize)/$startsize)

	if ( $RelativeDifference -le $MaxRelativeDifference )
	{
	    #seems oke

	    #remove the rar file
	    remove-item $filerar -Force


	}
	else	
	{
	    #rename rar to cbr
	    rename-item $filerar $filecbr
	
	    #copy cbr file to special directory (d:\RepackAgain)
	    copy-item -path $filecbr -destination 'D:\RepackAgain'
	
	    #remove cbz file
	    remove-item $filecbz -Force

	}

	#remove tmp and temp folder
	remove-item  'ztempz' -Recurse -Force
	remove-item  'ztmpz'  -Recurse -Force
 }   
    
    
set-location $Path

#remove 7zip alias
remove-item alias:zip

}

