$json=@'
[
  {
    "Handles": 140,
    "ProcessName": "winpty-agent",
    "Id": 8920
  },
  {
    "Handles": 150,
    "ProcessName": "winpty-bgent",
    "Id": 14608
  }
]
'@

#test 
Test-Json $json

$aa =  ConvertFrom-JSON -InputObject $json  # or  $json | ConvertFrom-JSON
$aa | Get-Member
$aa.Handles 
$aa.Handles[0]


## convert to JSON

$injson = Get-Process |Where-Object{$_.name -like 'winpty*'} | Select-Object -property	Handles,ProcessName, Id  | ConvertTo-Json
$injson


