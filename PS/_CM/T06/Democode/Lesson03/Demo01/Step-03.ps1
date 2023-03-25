############## Lesson 03 Demo 04 Step 03 ##############
####### Register JEA configuration on LON-SVR1 ########
#######################################################

$configurationName = 'adatum.windows.demoiismanagement'
$jeaSessionCfgLocalFile = Join-Path "c:\$jeaModulePath\$rcFolderName" $jeaSessionCfgFileName
Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    If (!(Get-PSSessionConfiguration -Name $using:configurationName -ErrorAction SilentlyContinue)) {
        Register-PSSessionConfiguration -Path $using:jeaSessionCfgLocalFile -Name $using:configurationName
    }
}
