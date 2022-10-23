$x = 5
$y = $null

$x + $y
$x * $y

$z = 'abc'
$y + $z

if ($y -eq 0){
  write-host 'NULL is equal to zero'
}
else {
  write-host 'NULL is not equal to zero'
}


($x).Length
($y).length
($z).length

# $null is not equivalent to NULL in SQL Server
# $null lijkt op blank() in DAX