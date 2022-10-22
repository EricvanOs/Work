<#
.SYNOPSIS
Queries a remote computer for BIOS information.
.DESCRIPTION
Use this script to obtain BIOS inforamtion from remote computers. You must have sufficient permissions to query this information.
.PARAMETER ComputerName
The name of the remote computer that is being queried.
.EXAMPLE
.\Query-Bios.ps1 -ComputerName LON-DC1
.EXAMPLE
.\Query-Bios.ps1 LON-DC1
#>
[cmdletbinding()]
Param (
    
    [ValidateNotNullOrEmpty()][string]$ComputerName = ($env:computerName)
)


try {
    Get-CimInstance Win32_BIOS -ComputerName $ComputerName -ErrorAction Stop
}
catch {
    Write-Host 'A (correct) ComputerName is required.'
}



# test
<#
Set-Location -Path K:\_cm\H07B
#>

<#
[ValidateCount()]	Minimum and maximum number of elements in an array
[ValidateDrive()]	Allowable drive letters in a path
[ValidateLength()]	Minimum and maximum length of a string
[ValidateNotNull()]	May not be $null
[ValidateNotNullOrEmpty()]	May neither be $null or an empty array or an empty string
[ValidatePattern()]	Must match a Regular Expression pattern
[ValidateRange()]	Must be a number in the given range
[ValidateScript()]	Validation script must return $true
[ValidateSet()]	Must be one of the listed strings
[ValidateTrustedData()]	Introduced in PowerShell 6, used internally
[ValidateUserDrive()]	Must be a path using the User drive. This drive can be defined in JEA (Just Enough Administration) session configurations.
#>
