############## Starting point of Lab B ###############
##### Create an additional web site on LON-SVR1 ######
######################################################

$remoteComputer = 'LON-SVR1'
$webSiteName = 'site02'
$webSiteFolder = "inetpub\$webSiteName"

Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    If (!(Get-WebSite -name $using:webSiteName)) {
        New-Item -Path "c:\$using:webSiteFolder" -ItemType Directory -ErrorAction SilentlyContinue
        New-WebSite -Name $using:webSiteName -Port 8082 -PhysicalPath "$env:systemdrive\$using:webSiteFolder" 
    }
    Start-Website -Name $using:webSiteName -ErrorAction SilentlyContinue
}

############## Beginning of Lab B Task 1 ##############
########### Configure JEA role capabilities ###########
#######################################################

$labFilesPath = 'E:\Allfiles\Mod06\Labfiles'
$jeaRoleCapabilityFileName = 'AdatumWebAdminJEARole.psrc'

$jeaRoleFilePath = "$labFilesPath\$jeaRoleCapabilityFileName"
If (!(Test-Path -Path $jeaRoleFilePath)) {
    New-PSRoleCapabilityFile -Path $jeaRoleFilePath
}

$jeaModulePath = 'Program Files\WindowsPowerShell\Modules\AdatumJEA'
$moduleFilePath = "\\$remoteComputer\c$\$jeaModulePath"
If (!(Test-Path -Path $moduleFilePath)){
    New-Item -Path $moduleFilePath -ItemType Directory
}

$moduleFileName = 'AdatumJEAFunctions.psm1'
$manifestFileName = 'AdatumJEA.psd1'
New-Item -Path (Join-Path $moduleFilePath $moduleFileName) -ErrorAction SilentlyContinue
New-ModuleManifest -Path "$(Join-Path $moduleFilePath $manifestFileName)" -RootModule $moduleFilePath -ErrorAction SilentlyContinue

$rcFolderName = 'RoleCapabilities'
$rcFolder = Join-Path $moduleFilePath $rcFolderName
If (!(Test-Path -Path $rcFolder)){
    New-Item -Path $rcFolder -ItemType Directory -ErrorAction SilentlyContinue
}
Copy-Item -Path $jeaRoleFilePath -Destination $rcFolder -Force


############## Beginning of Lab B Task 2 ##############
########## Create a JEA session configuration #########
#######################################################

$jeaSessionCfgFileName = 'AdatumWebAdminEndpoint.pssc'
$jeaSessionCfgFilePath = "$labFilesPath\$jeaSessionCfgFileName"
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


############## Beginning of Lab B Task 3 ##############
####### Register JEA configuration on LON-SVR1 ########
#######################################################

$configurationName = 'adatum.windows.iismanagement'
$jeaSessionCfgLocalFile = Join-Path "c:\$jeaModulePath\$rcFolderName" $jeaSessionCfgFileName
Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    If (!(Get-PSSessionConfiguration -Name $using:configurationName -ErrorAction SilentlyContinue)) {
        Register-PSSessionConfiguration -Path $using:jeaSessionCfgLocalFile -Name $using:configurationName
    }
}


############## Beginning of Lab B Task 4 ##############
###################### Test JEA #######################
#######################################################

$plainPassword = 'Pa55w.rd'
$secPassword = ConvertTo-SecureString -String $plainPassword -AsPlainText -Force
$adSAMAccountName = "ADATUM\$($adUser.SamAccountName)"
$credential = New-Object System.Management.Automation.PsCredential -ArgumentList $adSAMAccountName,$secPassword

Enter-PSSession -ComputerName $remoteComputer -ConfigurationName $configurationName -Credential $credential

