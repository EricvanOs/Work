$a = 2,3,4
$b = 5,6,7
$c = $a + $b

$c 
$c.GetType()  # niet $c | get-member

# idem
$a = @(2,3,4)
$b = @(5,6,7)
$c = $a + $b

$c
$c.GetType()