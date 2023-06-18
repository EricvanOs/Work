Connect-MgGraph -Scopes 'User.Read.All'


Get-MgUser -All

# Get the user by the UserPrincipalName
Get-MgUser -UserId adelev@lazydev.onmicrosoft.com

# Get the user by the actual id:
Get-MgUser -UserId 7a3b301d-0462-41b6-8468-19a3837b8ad1

<#
Operator	Description	Example
eq	Equals to	jobtitle eq ‘Marketing Assistant’
and	And	jobtitle eq ‘Recruiter’ and jobtitle eq ‘hr’
or	Or	jobtitle eq ‘Recruiter’ or jobtitle eq ‘hr’
startswith	String starts with	startswith(jobtitle,’recr’)
#>

# Find the user based on the full name
Get-MgUser -Filter "DisplayName eq 'Adele Vance'"

# Find the user by the first part of the name
Get-MgUser -Filter "startsWith(DisplayName, 'A')"


Get-MgUser -Filter "jobtitle eq 'Marketing Assistant'"

Get-MgUser -Filter 'accountEnabled eq true' -All

Get-MgUser -Filter "department eq 'Marketing' and jobtitle eq 'Manager'"

Get-MgUser -Filter "CreatedDateTime ge $((Get-Date).AddYears(-1).ToString("s"))Z"

Get-MgUser -Search 'DisplayName:van' -ConsistencyLevel eventual

Get-MgUser -Filter 'accountEnabled eq true' -Search 'DisplayName:van' -ConsistencyLevel eventual


Get-MgUser -UserId adelev@lazydev.onmicrosoft.com | Select DisplayName,BusinessPhones,Mail,JobTitle

DisplayName BusinessPhone     Mail                           JobTitle
----------- -------------     ----                           --------
Adele Vance {+1 425 555 0109} AdeleV@lazydev.onmicrosoft.com Retail Manager

Get-MgUser -UserId adelev@lazydev.onmicrosoft.com -ExpandProperty manager | Select @{Name = 'Manager'; Expression = {$_.Manager.AdditionalProperties.displayName}}

# Result:
Manager
-------
Miriam Graham
Connect-MgGraph -Scopes "User.Read.All","MailboxSettings.Read"

Get-MgUser -UserId rudymens@thunnissen.nl -Property MailboxSettings | Select @{Name = 'days'; Expression = {$_.MailboxSettings.WorkingHours.DaysofWeek}}

<#
.SYNOPSIS
  Get all Azure AD Users using Microsoft Graph with properties and export to CSV

.DESCRIPTION
  This script collects all Azure Active Directory users with the most important properties. By default it will only
  get the enabled users, manager of the user and searches the whole domain.

.OUTPUTS
  CSV with Azure Active Directory Users

.NOTES
  Version:        1.0
  Author:         R. Mens - LazyAdmin.nl
  Creation Date:  15 feb 2022
  Purpose/Change: Initial script development

.EXAMPLE
  Get all AzureAD users from the whole Domain

   .\Get-MgUsers.ps1 -path c:\temp\users.csv

.EXAMPLE
  Get enabled and disabled users

   .\Get-MgUsers.ps1 -enabled both -path c:\temp\users.csv

   Other options are : true or false

.EXAMPLE
  Don't lookup the managers display name
  .\Get-MgUsers -getManager:$false -path c:\temp\users.csv
#>


param(
  [Parameter(
    Mandatory = $false,
    HelpMessage = "Get the users manager"
  )]
  [switch]$getManager = $true,

  [Parameter(
    Mandatory = $false,
    HelpMessage = "Get accounts that are enabled, disabled or both"
  )]
    [ValidateSet("true", "false", "both")]
  [string]$enabled = "true",

  [Parameter(
    Mandatory = $false,
    HelpMessage = "Enter path to save the CSV file"
  )]
  [string]$path = ".\ADUsers-$((Get-Date -format "MMM-dd-yyyy").ToString()).csv"
)


Function Get-Users {
    <#
    .SYNOPSIS
      Get users from the requested DN
    #>
    process{
      # Set the properties to retrieve
      $properties = @(
        'id',
        'DisplayName',
        'userprincipalname',
        'mail',
        'jobtitle',
        'department',
        'OfficeLocation',
        'MobilePhone',
        'BusinessPhones',
        'streetAddress',
        'city',
        'postalcode',
        'state',
        'country',
        'AccountEnabled',
        'CreatedDateTime'
      )

      If (($getManager.IsPresent)) {
        # Adding additional properties for the manager
        $select = $properties += @{Name = 'Manager'; Expression = {$_.Manager.AdditionalProperties.displayName}}
        $select += @{Name ="Phone"; Expression = {$_.BusinessPhones}} 
      }else{
        $select = $properties
      }

      # Get enabled, disabled or both users
      switch ($enabled)
      {
        "true" {$filter = 'AccountEnabled eq true'}
        "false" {$filter = 'AccountEnabled eq false'}
        "both" {$filter = ''}
      }

      # Get the users
      Get-MgUser -Filter $filter -Property $properties -ExpandProperty Manager | select $select
    }
}


Function Get-AllMgUsers {
  <#
    .SYNOPSIS
      Get all AD users
  #>
  process {
    Write-Host "Collecting users" -ForegroundColor Cyan

    # Collect and loop through all users
    Get-Users | ForEach {

      [pscustomobject]@{
        "Name" = $_.DisplayName
        "UserPrincipalName" = $_.UserPrincipalName
        "Emailaddress" = $_.mail
        "Job title" = $_.JobTitle
        "Manager" = $_.Manager
        "Department" = $_.Department
        "Office" = $_.OfficeLocation
        "Phone" = $_.Phone
        "Mobile" = $_.MobilePhone
        "Enabled" = if ($_.AccountEnabled) {"enabled"} else {"disabled"}
        "Street" = $_.StreetAddress
        "City" = $_.City
        "Postal code" = $_.PostalCode
        "State" = $_.State
        "Country" = $_.Country
        "Account Created on" = $_.CreatedDateTime
      }
    }
  }
}

# Check if MS Graph module is installed
if (Get-InstalledModule Microsoft.Graph) {
  # Connect to MS Graph
  Connect-MgGraph -Scopes "User.Read.All"
}else{
  Write-Host "Microsoft Graph module not found - please install it" -ForegroundColor Black -BackgroundColor Yellow
  exit
}

Get-AllMgUsers | Sort-Object Name | Export-CSV -Path $path -NoTypeInformation

if ((Get-Item $path).Length -gt 0) {
  Write-Host "Report finished and saved in $path" -ForegroundColor Green

  # Open the CSV file
  Invoke-Item $path

}else{
  Write-Host "Failed to create report" -ForegroundColor Red
}