$bigarray = @()

Measure-Command -Expression {  @(0..29999).foreach({ $bigArray += $_ }) }

<#
+/- 23000 milliseconds
#>


$bigarray =  [System.Collections.ArrayList]@()

Measure-Command -Expression { @(0..29999).foreach({  $bigArray.Add($_) })}

<#
+/- 88 milliseconds
#>



