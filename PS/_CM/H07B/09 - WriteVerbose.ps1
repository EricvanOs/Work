Function Test-Verbose{
  [cmdletbinding()]
  Param()

  Write-Verbose "Verbose output"  
  Write-Host "Regular output" 
}

# nu testen
Test-Verbose 

Test-Verbose -Verbose 
