#Import-Module -Name SQLPS

$SQLServer = 'cyg7091'

# test Sales

$Database = 'Sales'

   
$results = $null
$ready = 0
while ($ready -eq 0)
{
         
    $strSurName = Read-Host -Prompt "strSurName w/ wildcard e.g. hendr%"

    $strGivenName = Read-Host -Prompt "strGivenName w/ wildcard e.g. han%"

   
$Query = @"
select strSurName,strGivenName, *  FROM [dbo].[tbl_sal_ReportAIRIssues]
 where strSurName like '$strSurName' and strGivenName like '$strGivenName'
"@


$Results = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query 

$Results | Format-Table

$rr = Read-Host -Prompt "ready?  Y/N"
    if ($rr  -eq 'Y')
    {
       $ready = 1 
    }

 }



if ($results -ne $null)
 {

$Q = @"
SELECT [ID]
      ,[strPersShortName]
      ,[intPMS_EmployeeNr]
      ,[strEmployeeEmail]
      ,[strEmployeeOperation]
      ,[intSupervisorNumber]
      ,[strSupervisorName]
      ,[strSupervisorEmail]
      ,[intAltea_EmployeeNR]
      ,[intAltea_Login]
      ,[strCompany]
      ,[strDepartment]
      ,[strOperation]
      ,[strClient]
      ,[strValidatingCarrier]
      ,[intAMDnumber]
      ,[strAMDindicator]
      ,[strSales_Type]
      ,[strSign_Code]
      ,[strPNR_Rec_Loc]
      ,[strPNR_Country]
      ,[strBookingEmployeeEMD]
      ,[strOriginatedOffice_ID]
      ,[strBookingOffice_ID]
      ,[strIssueOffice_ID]
      ,[datTransDate]
      ,[intPrimaryTicket]
      ,[intTicket_Org]
      ,[intTicket_Seq]
      ,[strTicketOwner]
      ,[strCarrierNum_Seq]
      ,[strSurName]
      ,[strGivenName]
      ,[strTitleName]
      ,[datImportDate]
      ,[datImportADFDate]
      ,[datBookingDate]
      ,[datIssueDate]
      ,[datIssueWeek]
      ,[datBookingWeek]
      ,[datIssueMonth]
      ,[datBookingMonth]
      ,[datIssueQuarter]
      ,[datBookingQuarter]
      ,[intIssueingAgent]
      ,[intIss_Agent_Code]
      ,[strIss_Agent_Name]
      ,[strBookingCityCode]
      ,[strBookingCountry]
      ,[strIssueCityCode]
      ,[strIssueCountryCode]
      ,[strIssueCountryName]
      ,[strIssCountryCygnific]
      ,[strBNLEUR]
      ,[intBagent]
      ,[strBagent_Name]
      ,[strSalesStatus]
      ,[strPayType]
      ,[strPayCCType]
      ,[strEurIca]
      ,[strIndicatorNF]
      ,[strTicketType]
      ,[strTicketTypeName]
      ,[strTicketCurrency]
      ,[intTicketValue]
      ,[strEqAmP_Cur]
      ,[intTV_EqAmP]
      ,[strTaxCurrency]
      ,[intTicketTax_Tax]
      ,[intTicketTax_Fuel]
      ,[intTicketTax_Country]
      ,[intTicketTax_General]
      ,[intTicketValueTotal]
      ,[intBooFeeTotal]
      ,[strBooFeeACurrency]
      ,[intBooFeeAValue]
      ,[strBooFeeCCurrency]
      ,[intBooFeeCValue]
      ,[strBkFeeTypeGen]
      ,[strBkFeeCurGen]
      ,[intBkFeeValueGen]
      ,[intNr_of_Tickets]
      ,[intNR_of_Coupons]
      ,[strPS_MarkOwn]
      ,[strPS_CarFee]
      ,[strPS_EMDValue]
      ,[strPS_EMDValueOwner]
      ,[strPS_performer]
      ,[strPS_ProductCode]
      ,[strPS_Product]
      ,[bitEducational]
      ,[bitConvertTicketValue]
      ,[bitConvertTaxValue]
      ,[bitConvertBkFeeGen]
      ,[bitUpdateTable]
      ,[bitValidatingCarrier]
      ,[strFileName]
      ,[bitVoucher]
      ,[bitConvertVoucherValue]
      ,[strVoucherCurrency]
      ,[intVoucherValue]
      ,[strVoucherType]
      ,[bitVoidReported]
      ,[bitEqAmP]
      ,[bitADF]
      ,[bitHighYield]
      ,[bitGroup]
      ,[bitBNLEURactive]
      ,[bitAF_Imp]
      ,[bitSalesEmpRM]
FROM [dbo].[tbl_sal_ReportAIRIssues]
where strSurName like '$strSurName' and strGivenName like '$strGivenName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Givenname,Surname) values(' $Q ',' $strGivenName ',' $strSurName ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query



$Q = @"
UPDATE [dbo].[tbl_sal_ReportAIRIssues] 
SET GDPR = 1, GDPR_Date = getdate()
where strSurName like '$strSurName' and strGivenName like '$strGivenName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query) values(' $Q ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query


# update Surname --> random string

$Q = @"
declare @random char(5)
declare @alphabet varchar(36) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
set @random =  
 substring(@alphabet, convert(int, rand()*36), 1) + 
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1);

update [dbo].[tbl_sal_ReportAIRIssues]   
set strSurName = @Random
where strSurName like '$strSurName' and strGivenName like '$strGivenName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query) values(' $Q ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}