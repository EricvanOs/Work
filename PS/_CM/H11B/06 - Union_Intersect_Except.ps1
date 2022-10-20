$a = (1,2,3,4)
$b = (1,3,4,5)
Compare-Object $a $b -PassThru -IncludeEqual                   # union
Compare-Object $a $b -PassThru -IncludeEqual -ExcludeDifferent # intersection


$a | Where-Object{-not ($b -contains $_)}   # difference

# or like this
$a = @(1, 2, 3)
$b = @(1, 2)
$c = @(2)

'Intersection $a ⋂ $b ⋂ $c'
$a | Where-Object {$_ -In $b} | Where-Object {$_ -In $c}

'Union $a ⋃ $b ⋃ $c'
$a + $b + $c | Select-Object -Unique

'Set difference $a - $b - $c (items in $a but not $b or $c)'
$a | Where-Object {$_ -NotIn $b} | Where-Object {$_ -NotIn $c}
