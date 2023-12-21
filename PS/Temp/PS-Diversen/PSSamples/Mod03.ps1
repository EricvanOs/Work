Get-Process | Where-Object {$_.id -gt 5000} | Sort-Object -Property id | Export-Csv -Path c:\procs.csv
ii C:\procs.csv

get-process
get-service

get-process | Get-Member
get-process | Get-Member -MemberType Properties
get-process | Get-Member -Name kill

get-service | Get-Member
Get-NetAdapter |Get-Member

#custom props tonen
get-service |format-table 
get-service |format-table  -Property name,StartType,Status

Get-Process | ft ProcessName,id,vm,cpu,ProcessName ,Name ,vm,ws,npm
Get-Process | format-list -Property ProcessName,id,vm,cpu,Name ,ws,npm
Get-Process | Format-List -Property name,*memory*
#groeperen
get-process | Format-Table -GroupBy company

get-service | Format-Wide -Column 5
get-service | Format-Wide -Column 5 


#oppassen voor property namen/kolomnamen
Get-DnsClientCache
Get-DnsClientCache | Get-Member
Get-DnsClientCache | ft recordname,recordtype,status #fout
Get-DnsClientCache | ft Name,Type,status #fout


#sorting
Get-Process | Sort-Object -Property id -Descending
Get-Process | Sort-Object  -Property processname -Unique
get-service | Sort-Object -Property Status
GET-service | Get-Member -Name status
GET-service | Get-Member -Name servicename

Get-Process | sort-object -Property Company| format-table -GroupBy company
get-process | Group-Object -Property company 

#tellen
Get-Command | Measure-Object
Get-Process | Measure-Object -Sum -Average -Minimum -Maximum -Property *memory*
Get-Content C:\procs.csv | Measure-Object -Line -Word -Character 
Get-ChildItem -Path 'C:\Program Files\Microsoft Learning\10961\Powerpnt'  | 
    Measure-Object -Property Length  -Sum


#select-object
Get-Process | Format-Table -Property name,id,vm   | Get-Member
Get-Process | select-object -Property name,id,vm | Get-Member   #verschil met format-table!!!!
Get-Process | select-object -Property name,id,vm ,pm,npm  #vanaf 5 props--> list format
Get-Process | select -First 10 -Last 5 -skip 5
Get-Process | select -First 10 -Last 5 -skip 5 -Property name,id,vm,pm
#calculated property
get-process | select name,@{n='VM(Kb)';e={($psitem.VM/1MB)}},PM, @{n='VM/PM'; e={ ($PSItem.VM/$psitem.PM)}}  

#formattering
1kb
1mb
1gb
1tb
1pb


"de prijs van benzine is {0} " -f 1.5
"de prijs van benzine is {0:c} " -f 1.535465
"de prijs van benzine is {0:N3} " -f 1.535465
"de prijs van {1} is {0:N3} " -f 1.535465,"benzine"


get-process | select name,@{n='VM(Kb)';e={ "{0,15:n2}" -f ($psitem.VM/1MB)}}


#filters
132 -gt 6545
"Darwin" -gt "darwin"
"Darwin" -cgt "darwin"
"Darwin"  -like "dar*"

get-service  |Where-Object Status -EQ Running
get-service  |Where-Object (Status -EQ Stopped) -and (StartType -eq 'Automatic')   #fout, mag niet
get-service  |Where-Object name.length -gt 12  #ook fout, maar geen error

get-service  |
Where-Object -FilterScript {($psitem.Status -EQ 'Stopped') -and ($psitem.StartType -eq 'Automatic')}   
get-service  |Where-Object {$psitem.name.length -gt 12}

#geen where-object nodig vaak
Get-ChildItem -Path c:\ -Recurse | Where-Object extension -eq ".ps1"
Get-ChildItem -Path c:\ -Recurse -Filter "*.ps1"   #efficienter
get-help Get-ChildItem -ShowWindow

Get-EventLog -LogName System | Where-Object EntryType -eq error
Get-EventLog -LogName System -EntryType Error  #efficienter

Get-Command -ParameterName filter

#lab
Get-ChildItem -Path Cert:\ -Recurse | where HasPrivateKey -eq $false  #cert: drive --> certificates

Get-Volume 
get-volume | Where-Object {($psitem.SizeRemaining/$psitem.size) -gt .85 -and $psitem.size -gt 0  } #volgorde!!
get-volume | Where-Object {$psitem.size -gt 0 -and ($psitem.SizeRemaining/$psitem.size) -gt .85}


#foreach-object
Get-ChildItem -Path c:\ | Get-Member
Get-ChildItem -Path C:\demo  | ForEach-Object -MemberName decrypt
Get-ChildItem -Path C:\demo  | ForEach-Object {$psitem.Encrypt()}   #haakjes by methods!!

Get-Service| foreach-object {write-host $PSItem.Name $PSItem.Status}

#output/export
Get-Process  | Out-Default
Get-service  | Out-File -FilePath c:\svc.txt
ii C:\svc.txt
Get-Process | Out-GridView -OutputMode Multiple | Sort-Object -Property id
Get-Process | Out-Null
Get-Process |Out-Printer -Name ...
Get-Process | Out-String  

#export
Get-Process | Export-Csv -Path c:\procs.csv 
ii C:\procs.csv
Get-Process | Export-Clixml -Path c:\procs.xml
Get-Process | Export-Clixml -Path c:\procs2.xml -Depth 1
Get-Process |ConvertTo-Csv -Delimiter ";" |Out-File -FilePath C:\procs2.csv
Get-Process |ConvertTo-Html -Title "Process info" -As Table `
    -PreContent "<font color='red'>Processen</font>" | out-file c:\procs.html
ii C:\procs.html
Get-Process |ConvertTo-Json  | Out-File c:\procs.json
ii C:\procs.json
Get-Process |ConvertTo-Json  -Compress  | Out-File c:\procs.json 


#compare 
$procs=Get-Process
Compare-Object -ReferenceObject (get-process) -DifferenceObject $procs
Compare-Object -ReferenceObject (get-process) -DifferenceObject $procs -IncludeEqual 
Compare-Object -ReferenceObject (get-process) -DifferenceObject $procs -IncludeEqual -ExcludeDifferent

compare-object -ReferenceObject (1..100) -DifferenceObject (100..1) -SyncWindow 40































