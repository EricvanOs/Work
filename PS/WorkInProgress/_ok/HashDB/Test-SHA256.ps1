Function Test-SHA256{
<#
.SYNOPSIS
Test if hash value is in database.
.DESCRIPTION
test if hash value is in database, returns 1 if value exists otherwise 0
.PARAMETER session
session to computer
.PARAMETER SHA256
The hashvalue (SHA256)
.EXAMPLE
.$ses = New-PSSession -ComputerName hypnos
.\Test-SHA256 -session $ses -SHA256 '3892adc'
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [System.Management.Automation.Runspaces.PSSession]
    $Session,

    [Parameter(Mandatory=$True)]
    #[Validatelength(64)]
    [String]
    $SHA256
)

 Invoke-Command -Session $Session -ScriptBlock{
    param($sha256) (Invoke-Sqlcmd -Query ('exec hash.dbo.usp_testsha256 ' + "'" + $sha256 + "'")).column1
 } -ArgumentList $sha256
}




