Function Get-FolderData {

  Param (
  [string]$Path=".",
  [datetime]$Cutoff,
  [string]$Filter="*.*"
  )

  #the path might be a . or a PSDrive shortcut so get the complete path
  $Folder = Get-Item -Path $path

  #Display a status message. 
  Write-Host "Getting file data from $Folder for $Filter" -ForegroundColor Green

#if $cutoff is specified, find the files last modified since the cutoff date.
  if ($Cutoff) {
      Write-Host "Getting files modified since $Cutoff" -ForegroundColor Green
      $data = Get-ChildItem -Path $path -Recurse -File -filter $Filter | 
      Where-Object {$_.LastWriteTime -ge $Cutoff}
  }
  else {
      $data = Get-ChildItem -Path $path -Recurse -File -filter $Filter
  }

  #measure the files
  Write-Host "Measuring files" -ForegroundColor Green
  $stats = $data | Measure-Object -Property length -sum -Minimum -Average -Maximum

  #write the result to the pipeline including a property for all of the files
  $stats | Select-Object -Property @{n="Folder";e={$Folder}},Count,
  @{n="Smallest";e={$_.Minimum}},
  @{n="Largest";e={$_.Maximum}},
  @{n="AvgSize";e={$_.Average}},
  @{n="TotalSize";e={$_.Sum}},
  @{n="Files";e={$data}}

} #end of function

Get-FolderData -Path c:\Tools

