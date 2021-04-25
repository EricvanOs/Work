Function Test-Verbose{
  [cmdletbinding()]
  Param()

  Write-Verbose "Verbose output" 
  Write-Host "Regular output"
}

# nu testen
Test-Verbose 

Test-Verbose -Verbose 

# kleur aanpassen van verbose output

$VerboseColor = $host.PrivateData.VerboseForegroundColor

$host.PrivateData.VerboseForegroundColor = 'Magenta'

Test-Verbose -Verbose 


# restore original colors 
$host.PrivateData.VerboseForegroundColor = $VerboseColor