Set-Location -Path K:\_CM\H12
Get-Content -Path .\Testfile1.txt
Get-Content -Path .\Testfile2.txt


# difference
Compare-Object -ReferenceObject (Get-Content -Path .\Testfile1.txt) -DifferenceObject (Get-Content -Path .\Testfile2.txt)


# equal
$objects = @{
    ReferenceObject = (Get-Content -Path .\Testfile1.txt)
    DifferenceObject = (Get-Content -Path .\Testfile2.txt)
  }
  Compare-Object @objects -ExcludeDifferent

 
  # compare on a property of object
  Compare-Object -ReferenceObject 'abc' -DifferenceObject 'xyz' -Property Length -IncludeEqual

  
