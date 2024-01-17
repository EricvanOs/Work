# choosing azcmagent.exe which runs on morpheus
# verify
Enter-PSSession -ComputerName morpheus

azcmagent 
azcmagent show --json

Exit-PSSession
# Keep in mind utility to 'Amplify' is not necessarily installed on development machine

Set-Location -Path 'C:\Work\PS\_Various Scripts\Crescendo'

# Create 'new' folder for Module
New-Item -Path .\AZCMAgent -ItemType Directory
Set-Location .\AZCMAgent

# Create CrescondoCommand Json-file
$parameters = @{
    Verb = 'Show'
    Noun = 'AzCmAgent'
    OriginalName = "c:/program files/AzureConnectedMachineAgent/azcmagent.exe"
}
$CrescendoCommands += New-CrescendoCommand @parameters
Export-CrescendoCommand -command $CrescendoCommands -targetDirectory .


# Show-AzCmAgent.crescendo.json will be generated (on HD available as Show-AzCmAgent.crescendo.original.json)
# this file has to be extended 

code .\Show-AzCmAgent.crescendo.json

# extending the json-file


# creating a Module
Export-CrescendoModule -ConfigurationFile Show-AzCmAgent.Crescendo.json -ModuleName AzCmAgent.psm1 -force

# copy folder AZCMAgent (and psd1, psm1) to 'PSModulePath' accessible by Morpheus 

# test on Morpheus

