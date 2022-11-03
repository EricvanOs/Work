# Run a command as a different user

#Get UserB credential
$Credential = Get-Credential itdroplets\UserB
#Start the Job as UserB
$GetProcessJob = Start-Job -ScriptBlock {Get-Process Explorer} -Credential $Credential
#Wait until the job is completed
Wait-Job $GetProcessJob
#Get the Job results
$GetProcessResult = Receive-Job -Job $GetProcessJob
#Print the Job results
$GetProcessResult