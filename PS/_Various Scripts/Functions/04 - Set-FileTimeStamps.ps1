#Set-FileTimeStamps function

Function Set-FileTimeStamps{
  Param (
    [Parameter(mandatory=$true)]
    [string[]]$Path,

    [datetime]$Date = (Get-Date))

    Get-ChildItem -Path $Path |
      ForEach-Object {
        $_.CreationTime = $date
        $_.LastAccessTime = $date
        $_.LastWriteTime = $date 
      }
} #end function Set-FileTimeStamps

$Path = 'K:\_CM\_Various Scripts\Functions'
Set-Location -Path $Path

Set-FileTimeStamps -Path $Path
Set-FileTimeStamps -Path $Path -Date '2019-06-08'
