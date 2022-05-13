# if needed
# Install-Module -Name MicrosoftTeams

# if needed
# Update-Module -Name MicrosoftTeams

# connect to Teams
Connect-MicrosoftTeams

Get-Command  -Module MicrosoftTeams


$teams = Get-Team     
$teams