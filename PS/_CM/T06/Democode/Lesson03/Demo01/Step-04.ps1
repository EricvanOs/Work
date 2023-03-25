############## Lesson 03 Demo 04 Step 04 ##############
###################### Test JEA #######################
#######################################################

$plainPassword = 'Pa55w.rd'
$secPassword = ConvertTo-SecureString -String $plainPassword -AsPlainText -Force
$adSAMAccountName = "ADATUM\$($adUser.SamAccountName)"
$credential = New-Object System.Management.Automation.PsCredential -ArgumentList $adSAMAccountName,$secPassword

Enter-PSSession -ComputerName $remoteComputer -ConfigurationName $configurationName -Credential $credential

