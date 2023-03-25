############## Lesson 03 Demo 04 Step 02 ##############
########## Create a JEA session configuration #########
#######################################################

$jeaSessionCfgFileName = 'AdatumWebAdminEndpoint.pssc'
$jeaSessionCfgFilePath = "$demoFilesPath\$jeaSessionCfgFileName"
If (!(Test-Path -Path $jeaSessionCfgFilePath)) {
    New-PSSessionConfigurationFile -SessionType RestrictedRemoteServer -Path $jeaSessionCfgFilePath -Full
}

Test-PSSessionConfigurationFile -Path $jeaSessionCfgFilePath

$adGroupName = 'IISAdmins'
$adUserName = 'Abbi'
If (!(Get-ADGroup -Filter {sAMAccountName -eq $adGroupName})){
    New-ADGroup -Name $adGroupName -GroupCategory Security -GroupScope DomainLocal -Path 'OU=IT,DC=adatum,DC=com'
}
$adGroup = Get-ADGroup -Filter {sAMAccountName -eq $adGroupName}
$adUser = Get-ADUser -Filter {sAMAccountName -eq $adUserName}

Add-ADGroupMember -Identity $adGroup.SamAccountName -Members $adUser.DistinguishedName

Copy-Item -Path $jeaSessionCfgFilePath -Destination $rcFolder -Force

