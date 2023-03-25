############## Lesson 03 Demo 04 Step 01 ##############
########### Configure JEA role capabilities ###########
#######################################################

$demoFilesPath = 'E:\Allfiles\Mod06\Democode\Lesson03\Demo01'
$jeaRoleCapabilityFileName = 'AdatumWebAdminJEARole.psrc'

$jeaRoleFilePath = "$demoFilesPath\$jeaRoleCapabilityFileName"
If (!(Test-Path -Path $jeaRoleFilePath)) {
    New-PSRoleCapabilityFile -Path $jeaRoleFilePath
}

$remoteComputer = 'LON-SVR1'
$jeaModulePath = 'Program Files\WindowsPowerShell\Modules\AdatumJEA'
$moduleFilePath = "\\$remoteComputer\c$\$jeaModulePath"
If (!(Test-Path -Path $moduleFilePath)){
    New-Item -Path $moduleFilePath -ItemType Directory
}

$moduleFileName = 'AdatumJEA.psm1'
$manifestFileName = 'AdatumJEA.psd1'
New-Item -Path (Join-Path $moduleFilePath $moduleFileName) -ErrorAction SilentlyContinue
New-ModuleManifest -Path "$(Join-Path $moduleFilePath $manifestFileName)" -RootModule $moduleFilePath -ErrorAction SilentlyContinue

$rcFolderName = 'RoleCapabilities'
$rcFolder = Join-Path $moduleFilePath $rcFolderName
If (!(Test-Path -Path $rcFolder)){
    New-Item -Path $rcFolder -ItemType Directory -ErrorAction SilentlyContinue
}
Copy-Item -Path $jeaRoleFilePath -Destination $rcFolder -Force

