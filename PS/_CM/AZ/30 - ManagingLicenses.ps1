# import with parameter , run Get-Module -list AzureAD ; PSEdition = Desk 
# vooralsnog zijn beide imports nodig 

Import-Module AzureAD -SkipEditionCheck
Import-Module AzureAD -UseWindowsPowerShell
Connect-AzureAD 


<#
Reviewing licenses by using AzureAD cmdlets
You can use the Get-AzureADSubscribedSku cmdlet to review the licenses available in your Microsoft
365 tenant. The following example retrieves licenses and displays information about them. The SkuId
property is the GUID for the license:
#>

Get-AzureADSubscribedSku | Select-Object -Property Sku*,ConsumedUnits -ExpandProperty PrepaidUnits

<#
The service plans for a license are stored in the ServicePlans property. The following example places all
licenses in a variable and then displays the service plans for the first item in the array. The provisioning
status for the service plan indicates whether it's enabled or disabled for that user:
#>

$sku = Get-AzureADSubscribedSku
$sku[0].ServicePlans

<#
Managing licenses by using Azure AD cmdlets
You can use the Set-AzureADUserLicense cmdlet to assign a license to a user. Licenses to be added are
contained in an AssignedLicenses object that you create. For each license that you want to add, you create
an AssignedLicense object and add it to the AddLicenses property of the AssignedLicenses object.
After the AssignedLicenses object is configured, you apply it to the user account. The following example
creates a license object for Microsoft 365 E3, and then assigns it to a user:
#>

$License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$License.SkuId = '05e9a617-0261-4cee-bb44-138d3ef5d965'
$LicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
$LicensesToAssign.AddLicenses = $License

Set-AzureADUserLicense -ObjectId AbbieP@adatum.com -AssignedLicenses $LicensesToAssign

<#
If you want to disable service plans for a user, you need to add the GUID for the service plans to the
DisabledPlans property of the license object. 
The following example depicts how to disable the YAMMER_ENTERPRISE and SWAY service plans in a license:
#>

$License.DisabledPlans = '7547a3fe-08ee-4ccb-b430-5077c5041653'
$License.DisabledPlans.Add('a23b959c-7ce8-4e57-9140-b90eb88a9e97')

<#
To remove a license, you add a license to the RemoveLicenses property of an AssignedLicenses object.
The following example removes a Microsoft 365 E3 license from a user account:
#>

$License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$License.SkuId = '05e9a617-0261-4cee-bb44-138d3ef5d965'
$LicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
$LicensesToAssign.RemoveLicenses = $License
Set-AzureADUserLicense -ObjectId AbbieP@adatum.com -AssignedLicenses $LicensesToAssign