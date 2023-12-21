
# list of all dtsx in all jobs

$a = Get-DbaAgentJobStep -SqlInstance cyg7091| Select-Object -ExpandProperty Properties | Where-Object{$_.name -eq 'Command'} 

($a.value) -split "\\" | Where-Object{$_ -like '*.dtsx'}



# which job(s) use a specific dtsx

$dtsx = 'Absence.dtsx'

Get-DbaAgentJobStep -SqlInstance cyg7091 | Select-Object -Property *  | Where-Object{$_.Properties -like "*$dtsx*"} | Select-Object -Property Urn


# which dtsx(s) are being used in a specific job

$job = 'Rep_Absence'

$a = Get-DbaAgentJobStep -SqlInstance cyg7091 -job $job | Select-Object -ExpandProperty Properties | Where-Object{$_.name -eq 'Command'} 

($a.value) -split "\\" | Where-Object{$_ -like '*.dtsx'}






