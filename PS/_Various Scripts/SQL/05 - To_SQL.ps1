$ComputerName = 'eos.pantheon.somewhere','clio'

$Database = 'master'

$Query = @'
select name,recovery_model_desc from sys.databases
'@


$NoTimeout = New-PSSessionOption -OperationTimeout 0
$ses = New-PSSession -ComputerName $ComputerName -SessionOption $NoTimeout 
Invoke-Command -Session $ses  -ScriptBlock{

   Invoke-Sqlcmd -Database $using:Database -Query $using:Query 
   
    
}  -AsJob -JobName 'SQLQuery'

Get-Job -Name 'SQLQuery' | Wait-Job

$j = Receive-Job -Name 'SQLQuery'

Get-Job -Name 'SQLQuery'| Remove-Job

Remove-PSSession -Session $ses

$j 

