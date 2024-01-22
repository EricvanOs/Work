# see: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-modulemanifest?view=powershell-7.3

<#
The first time that you run a command from an installed module, PowerShell automatically imports that module. 
The module must be stored in the locations specified in the $env:PSModulePathenvironment variable. 
Modules in other locations must be imported using the Import-Module cmdlet.
#>

Get-Help  New-ModuleManifest  -online


$env:PSModulePath

# import-module with verbose
Import-Module -Name 'C:\PowerShell-Scripts\Modules\HashDB' -Verbose
# or
Import-Module -Name HashDB -Verbose