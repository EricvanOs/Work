$x = $null
$y = 56
$z = 'abc'

$x + $y
$x * $y
$x + $z

if ($x -eq 0){
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