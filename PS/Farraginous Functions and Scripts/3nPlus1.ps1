function 3nplus1{
  param (
    [uint64]$n
  )

<#
n = 1  stop
n even --> n/2
n oneven --> 3n + 1
#>

  [uint64]$max = $n
  [UInt64]$steps = 1

  write-host $n
  while ($n -ne 1) {
    if ($n -ge $max) { $max = $n}  
    if (($n % 2) -eq 0 ) { $n = $n/2 } 
    else { $n = 3 * $n + 1  } 
    $steps += 1
    write-host $n
  }

  write-host "`r`n"
  write-host "Maximum is $max in $steps steps"
}

#test
# 3nPlus1(3)