$path = '\\pantheon\pi\Comic'

$tempdir = 'D:\Extract'
if ((Test-Path -Path $tempdir) -eq $false){New-Item -Path 'D:\' -name Extract -ItemType 'directory'}

#set alias to command line version of 7zip
set-alias zip 'C:\Program Files\7-Zip\7z.exe'

$files = Get-ChildItem -Path $path  -recurse -include *.cbr,*.cbz |  where-object{$_.attributes -eq 'Archive'}
$ses = New-PSSession -ComputerName clio
set-location $tempdir

foreach ($file  in $files){
    if ($file.Extension -eq '.cbr')
    {
      # get hash, save hash
      $sha256 = (Get-FileHash -Path $file  -Algorithm SHA256).hash
      Set-SHA256 -Session $ses -sha256 $sha256

      #change Archive attribute
      $file.attributes = $file.Attributes -bxor ([System.IO.FileAttributes]::Archive)
    }
    else
    {
      # get hash, save hash 
      $sha256 = (Get-FileHash -Path $file  -Algorithm SHA256).hash
      Set-SHA256 -Session $ses -sha256 $sha256    

      # get xorhash, save xorhash
      zip e -oztempz  $file
      $sha256 = Get-XorHash -Path ("$tempdir" + '\ztempz')  -Algorithm SHA256
      remove-item  'ztempz' -Recurse -Force
      Set-SHA256 -Session $ses -sha256 $sha256 
            
      #change Archive attribute
      $file.attributes = $file.Attributes -bxor ([System.IO.FileAttributes]::Archive) 
    }

}

Remove-PSSession $ses

set-location 'c:\'
remove-item $tempdir  -force


