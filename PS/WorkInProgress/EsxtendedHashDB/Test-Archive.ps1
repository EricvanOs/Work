function Test-Archive{
<#
.SYNOPSIS
test archive (cbr,cbz) files
.DESCRIPTION
test archive, corrupted files are placed in ErrorPath
.PARAMETER Path
The path to find archive-files 
.PARAMETER Move
want to move file y/n default N
.PARAMETER ErrorPath
Path to move corrupted files to
.EXAMPLE
.\Test-Archive -Path 'C:\temp' -Move Y -ErrorPath 'D:\Err'
#>
[CmdletBinding()]
Param(
    [Parameter()]
    [string]
    $Path = '\\aphrodite\_ToTestAgainstHashDB',

    [Parameter()]
    [ValidateSet('N', 'Y')]
    [string]
    $Move = 'N',

    [Parameter()]
    [string]
    $ErrorPath = 'D:\Errors'

)

#set alias to command line version of 7zip
set-alias zip 'C:\Program Files\7-Zip\7z.exe'

Set-Location $Path

# all cbz-files
$files = get-childitem  -recurse -include *.cbr,*.cbz

$IsCorrupted = 0

foreach($file in $files){

    
    $ee = $NULL
	$ee = (zip  t $file) | select-string 'Error'
	 
	if ($ee -ne $NULL){
        $IsCorrupted = 1 # one of the files is corrupted
        if ($move -eq 'Y'){
		move-item $file -destination $ErrorPath
        }
	 }
	

}


#remove zip alias
remove-item alias:zip

return $IsCorrupted
}



