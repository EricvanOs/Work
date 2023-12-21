#
# Script module for module 'AIR'
#

get-childitem -path $PSScriptRoot\*.ps1 | foreach-object{ . $_.FullName}
