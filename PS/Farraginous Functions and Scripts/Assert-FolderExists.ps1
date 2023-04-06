function Assert-FolderExists
{
  param
  (
    [Parameter(Mandatory,ValueFromPipeline)]
    [string[]]
    $Path
  )
  
  process
  {
    foreach($_ in $Path)
    {
      $exists = Test-Path -Path $_ -PathType Container
      if (!$exists) { 
        Write-Warning "$_ did not exist. Folder created."
        $null = New-Item -Path $_ -ItemType Directory 
      }
    }
  }
}

<#
Now you can use Assert-FolderExists both via pipeline and via parameters:

# making sure the path assigned to a variable exists:
($Path = 'c:\test3') | Assert-FolderExists

# making sure a bunch of paths exist:
Assert-FolderExists -Path 'c:\test4', 'c:\test5'
#>