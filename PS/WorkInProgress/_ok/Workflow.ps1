Workflow Ping-Host ([string[]] $targets)
{
    ForEach -Parallel ($target in $targets)
     {
     If (Test-Connection -ComputerName $target -Count 1 -Quiet)
         {
         "$target is alive"
         } Else 
         {
        "$target is down"
         }
     }
}

ping-host sisyphus,cerberus,abc


$IP = 1..254 | ForEach-Object{"192.168.82.$_"}

Ping-Host -Targets $IP

#############################

$aa = 0..99 
forEach ($a in $aa) {Start-Sleep -Milliseconds 100 }
Measure-Command { forEach ($a in $aa) {Start-Sleep -Milliseconds 100 } }  # hoelang duurt 't nu?


workflow  Test-Parallel ([int[]] $xx)
{
    foreach -Parallel ($x in $xx){Start-Sleep -Milliseconds 100}
}
 
 
Measure-Command{ Test-Parallel -xx $aa }