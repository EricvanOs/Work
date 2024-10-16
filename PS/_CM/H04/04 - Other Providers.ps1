# certificate stores
Push-Location cert:

Get-ChildItem

Set-Location -Path Cert:\CurrentUser\My

Get-ChildItem

Pop-Location


# environment
Push-Location env:

Get-ChildItem

$env:COMPUTERNAME

Pop-Location 


# SCCM of Hermes
Enter-PSSession -ComputerName Hermes

$SiteCode = "ATE" # Site code 
$ProviderMachineName = "hermes.pantheon.somewhere" # SMS Provider machine name

# Customizations
$initParams = @{}
#$initParams.Add("Verbose", $true) # Uncomment this line to enable verbose logging
#$initParams.Add("ErrorAction", "Stop") # Uncomment this line to stop the script on any errors

# Do not change anything below this line

# Import the ConfigurationManager.psd1 module 
if($null -eq (Get-Module ConfigurationManager) ) {
    Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1" @initParams 
}

# Connect to the site's drive if it is not already present
if($null -eq (Get-PSDrive -Name $SiteCode -PSProvider CMSite -ErrorAction SilentlyContinue)) {
    New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $ProviderMachineName @initParams
}

# Set the current location to be the site code.
Set-Location "$($SiteCode):\" @initParams

Set-Location -Path C:

Exit-PSSession


# Active directory
Enter-PSSession -ComputerName sisyphus

Import-Module -Name ActiveDirectory

Push-Location -Path AD:

Get-ChildItem
Set-Location -Path 'DC=pantheon,DC=somewhere'
Get-ChildItem
Set-Location -Path 'OU=PSTest'
New-Item -ItemType user -path . -name "CN=Sam Sample"
Remove-Item ".\CN=Sam Sample" -Confirm:$false -Force
Pop-Location 

Exit-PSSession


# alias

Push-Location alias:

Get-ChildItem

Pop-Location


# function

function myfunction {
Write-Host 'Some output'
}

myfunction

Push-Location function:

Get-ChildItem -Path my* | Select-Object -Property *

Pop-Location 

