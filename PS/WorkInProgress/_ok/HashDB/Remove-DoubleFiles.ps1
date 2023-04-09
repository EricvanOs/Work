$path = '\\cerberus\_ToTestAgainstHashDB'

$tempdir = 'D:\Extract'
if ((Test-Path -Path $tempdir) -eq $false){New-Item -Path 'D:\' -name Extract -ItemType 'directory'}

new-item  -Path $path -Name  __if_this_file_is_gone_then_process_is_finished -ItemType 'file'

#set alias to command line version of 7zip
set-alias zip 'C:\Program Files\7-Zip\7z.exe'

$files = Get-ChildItem -Path $path  -recurse -include *.cbr,*.cbz
$ses = New-PSSession -ComputerName clio
set-location $tempdir

foreach ($file  in $files){
    $remove = 0
    if ($file.Extension -eq '.cbr')
    {
      # get hash
      $sha256 = (Get-FileHash -Path $file  -Algorithm SHA256).hash
      #test if to remove file
      if ( (Test-SHA256 -Session $ses -sha256 $sha256) -eq 1){$remove = 1}
    }
    else
    {
      # get hash 
      $sha256 = (Get-FileHash -Path $file  -Algorithm SHA256).hash
      #test if to remove file
      if ( (Test-SHA256 -Session $ses -sha256 $sha256) -eq 1){$remove = 1} 

      # get xorhash
      if($remove -eq 0){
          zip e -oztempz  $file
          $sha256 = Get-XorHash -Path ("$tempdir" + '\ztempz')  -Algorithm SHA256
          remove-item  'ztempz' -Recurse -Force
          #test if to remove file
          if ( (Test-SHA256 -Session $ses -sha256 $sha256) -eq 1){$remove = 1} 
          }
    }
    if($remove -eq 1){remove-item $file -force}
}

Remove-PSSession $ses

set-location 'c:\'
remove-item $tempdir -force

remove-item -path ($path + '\' + '__if_this_file_is_gone_then_process_is_finished')