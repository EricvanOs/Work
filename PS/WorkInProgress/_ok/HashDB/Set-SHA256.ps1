Function Set-SHA256{
<#
.SYNOPSIS
inserts hash value in database.
.DESCRIPTION
inserts hash value in database, returns 0 if not succeeded otherwise 1
.PARAMETER session
session to computer
.PARAMETER SHA256
The hashvalue (SHA256)
.EXAMPLE
.$ses = New-PSSession -ComputerName hypnos
.\Set-SHA256 -session $ses -SHA256 '3892adc'
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
    param($sha256) (Invoke-Sqlcmd -Query ('exec hash.dbo.usp_insertsha256 ' + "'" + $sha256 + "'")).column1
 } -ArgumentList $sha256
}



