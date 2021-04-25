#1
$quantity = Read-Host 'Query how many log entries?'

#2 "oude stijl"
Invoke-Command -ArgumentList $quantity -ComputerName sisyphus -ScriptBlock {
   Param($x) Get-EventLog -LogName Security -newest $x }

# duidelijker
Invoke-Command -ComputerName sisyphus -ScriptBlock {Get-EventLog -LogName Security -Newest $Using:quantity}

#4 Dit werkt niet
Invoke-Command -ComputerName sisyphus -ScriptBlock {Get-EventLog -LogName Security -Newest $quantity}



