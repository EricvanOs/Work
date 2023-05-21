# for-loop
for ($i=1; $i -le 10; $i++) {$i}
for ($i=2; $i -le 1000; $i=$i*$i) {$i}


# while-loop
while(($inp = Read-Host -Prompt 'Select a command') -ne 'Q'){
   switch($inp){
      L {'File will be deleted'}
      A {'File will be displayed'}
      R {'File will be write protected'}
      Q {'End'}
      default {'Invalid entry'}
   }
}

# do-while  - loop
$i=1
do{
   Write-Host "$i"
   $i++
} while ($i -le 5)

# do-until - loop

$i=1
do{
   Write-Host "$i"
   $i++
} until ($i -gt 5)


# bad practice
$i=1;$j=1
while($i -lt 20){
   write-host "$i $j"
   if(($i % 7) -eq 0) {break :DoLoop}
   $j++
   $i=$i+$j 
}
:DoLoop do{
   Write-Host "$i"
   $i++
}
until($i -gt 25)