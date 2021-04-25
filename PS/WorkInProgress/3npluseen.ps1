<#
n = 1  stop
n even --> n/2
n oneven --> 3n + 1
#>

[uint64]$n = 27
[uint64]$max = $n

write-host $n
while ($n -ne 1) {
  if ($n -ge $max) { $max = $n}  
   if (($n % 2) -eq 0 ) { $n = $n/2 } 
   else { $n = 3 * $n + 1  } 
   write-host $n
   }

write-host "`r`n"
write-host "Maximum is $max"