$path = 'K:\EOS'
$sqlserver = 'Eos'

$jobs = Get-DbaAgentJob -SqlInstance $sqlserver

foreach ($job in $jobs){
  Export-DbaScript -InputObject $job -Path (join-path -Path $path ($job.Name + '.sql'))
  }