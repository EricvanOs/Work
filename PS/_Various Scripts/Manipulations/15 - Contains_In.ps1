$colla = 'one','two','three'
$collb = 'one','two'

$colla -contains 'one'

$colla -contains 'four'

$colla -contains $collb  #letop

Get-Help about_Comparison_Operators -ShowWindow

'one' -in $colla

'four' -in $colla

$collb -in $colla  # letop