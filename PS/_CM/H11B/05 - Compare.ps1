Set-Location -Path C:\Work\PS\_CM\H11B
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

  
