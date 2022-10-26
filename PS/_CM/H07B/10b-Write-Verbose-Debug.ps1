param(
    [switch]$Verbose,
    [switch]$Debug
)
# save the current preferences to restore later
$CurrentVerbosePreference = $VerbosePreference
$CurrentDebugPreference = $DebugPreference
   
# change verbose and/or debug preferences based on parameters
if ($Verbose){
    $VerbosePreference = 'Continue'
}
if ($Debug){
    $DebugPreference = 'Continue'
}
   
# you'll only see these if the corresponding parameter is used
Write-Verbose "I'm chatty!"
Write-Debug "Don't use me lightly!"
   
# cmdlet switches aren't affected and should produce the same output as the next two cmdlets
Get-ChildItem c:\junk\Untitled-22.ps1 -Verbose
Get-ChildItem C:\junk\Untitled-22.ps1 -Debug
   
# the same cmdlets, without the verbose/debug switches
Get-ChildItem c:\junk\Untitled-22.ps1
Get-ChildItem c:\junk\Untitled-22.ps1
   
$VerbosePreference = $CurrentVerbosePreference
$DebugPreference = $CurrentDebugPreference