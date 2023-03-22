$n = 1..10000

Measure-Command {
    $a = 0
    foreach ($i in $n) {
    $a+=$i
    }
}

Measure-Command {
    $n | ForEach-Object -Begin { $a = 0 } -process { $a+=$_ }
}