[uint64]$a =  89  # 7889, 196
[uint64]$c =   0

do {
    $a = $a  + $c 
    $b = $a.tostring().ToCharArray()
    [array]::Reverse($b)
    [uint64]$c = -join($b)
    write-host $a
} until ($a -eq $c)

