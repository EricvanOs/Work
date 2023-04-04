$path = 'K:\EOS'
$sqlserver = 'Eos'

$jobs = Get-DbaAgentJob -SqlInstance $sqlserver

foreach ($job in $jobs){
  Export-DbaScript -InputObject $job -Path (Join-Path -Path $path ($job.Name + '.sql'))
  }