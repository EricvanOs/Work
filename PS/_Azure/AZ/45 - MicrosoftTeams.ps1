Import-Module MicrosoftTeams

# connect to Teams
Connect-MicrosoftTeams

Get-Command  -Module MicrosoftTeams


$teams = Get-Team  -ProgressAction SilentlyContinue
$teams | Select-Object -Property *

