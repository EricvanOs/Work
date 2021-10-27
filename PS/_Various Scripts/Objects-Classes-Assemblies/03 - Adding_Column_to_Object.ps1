# Adding an extra column to process object, e.g. which services are being used by a given process


$processes = Get-Process | Select-Object processname, path, Id

# Search all services which belong to a certain (process)Id, and add it as an additional column
#example 
Get-Process -name lsass  # e.g. 652, look for all services with same process id (652)
Get-CimInstance "Win32_Service" | Where-Object{$_.processid -eq 768} | select-object -Property name



Foreach($p in $processes)
{
  $services = Get-CimInstance 'Win32_Service' | Where-Object{$_.processid -eq $p.id}
  Add-Member -InputObject $p -MemberType NoteProperty  -Name 'Services' -Value $(($services | 
    ForEach-Object {$_.name}) -join ',') -Force
}

$processes | Select-Object -Property processname,services

$processes | Get-Member
