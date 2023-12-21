#Import-Module -Name sqlserver

$SQLServer = 'cyg7091'

# cleanup
Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "truncate table dbo.GDPR"

#init
$surname = '%'
$Companyname = '%'
$EmailFrom = '%'

#############################

# test Bluebizz table Leads
$Database = 'BlueBizz'

Write-Host "Searching database $Database (tables Leads)" -ForegroundColor Cyan
$results = $null
$ready = 0
while ($ready -eq 0)
{
    
    $Surname = Read-Host -Prompt "Surname w/ wildcard e.g. hendriks%"

    $CompanyName  = Read-Host -Prompt "CompanyName"

$Query = @"
SELECT * from [dbo].[tblBLueBizzLeads] where Surname like '$Surname' and CompanyName like '$CompanyName'
"@


$Results = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query 

$Results | Format-Table

$rr = Read-Host -Prompt "ready? Y/N"
    if ($rr -eq 'Y')
    {
       $ready = 1 
       $Apply = Read-host -prompt "Apply changes Y/N"
       if ($Apply -eq 'Y'){$Skip = 0} else {$Skip = 1}
    }

 }

 # save the query and parameters which where used
 if ($results -ne $null)
 {
 
$Q = @"
SELECT [ID]
      ,[DateReport]
      ,[Language]
      ,[Gender]
      ,[SurName]
      ,[CompanyName]
      ,[Email]
      ,[Telephone]
      ,[BBNumber]
      ,[KvKnumber]
      ,[Remarks]
      ,[DateImport] 
from [dbo].[tblBLueBizzLeads] where Surname like '$Surname' and CompanyName like '$CompanyName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Surname,CompanyName,Skip,DB) values('$Q','$Surname' , ' $CompanyName', '$Skip','$Database')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}

#####################################


# test Bluebizz table Leads_Hist
$Database = 'BlueBizz'

Write-Host "Searching database $Database (tables Leads_hist)" -ForegroundColor Cyan
$results = $null
$ready = 0
while ($ready -eq 0)
{
    
    # $Surname = Read-Host -Prompt "Surname w/ wildcard e.g. hendriks%"

    # $CompanyName  = Read-Host -Prompt "CompanyName"

$Query = @"
SELECT * from [dbo].[tblBLueBizzLeads_Hist] where Surname like '$Surname' and CompanyName like '$CompanyName'
"@


$Results = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query 

$Results | Format-Table

$rr = 'Y'
    if ($rr -eq 'Y')
    {
       $ready = 1 
       $Apply = Read-host -prompt "Apply changes Y/N"
       if ($Apply -eq 'Y'){$Skip = 0} else {$Skip = 1}
    }

 }

 # save the query and parameters which where used
 if ($results -ne $null)
 {
 
$Q = @"
SELECT [ID]
      ,[DateReport]
      ,[Month]
      ,[Language]
      ,[Gender]
      ,[SurName]
      ,[CompanyName]
      ,[Email]
      ,[Telephone]
      ,[BBNumber]
      ,[KvKnumber]
      ,[Remarks]
      ,[DateImport] 
from [dbo].[tblBLueBizzLeads_Hist] where Surname like '$Surname' and CompanyName like '$CompanyName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Surname,CompanyName,Skip,DB) values('$Q','$Surname' , '$CompanyName', '$Skip','$database')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}


##############################################

# test Click2Chat

$Database = 'Click2Chat'
Write-Host "Searching database $Database" -ForegroundColor Cyan
   
$results = $null
$ready = 0
while ($ready -eq 0)
{
      
    $MailFrom = Read-Host -Prompt "MailFrom w/ wildcard e.g. ax@abc.s%;"

   
$Query = @"
SELECT mailFrom,* from dbo.tblAvayaWebCom where MailFrom like '$MailFrom'
"@


$Results = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query 

$Results | Format-Table

$rr = Read-Host -Prompt "ready? Y/N"
    if ($rr -eq 'Y')
    {
       $ready = 1 
       $Apply = Read-host -prompt "Apply changes Y/N"
       if ($Apply -eq 'Y'){$Skip = 0} else {$Skip = 1}
    }

 }




if ($results -ne $null)
 {

$Q = @"
SELECT [Importdate]
      ,[Reportdate]
      ,[ArrivalTime]
      ,[ContactOpenTime]
      ,[FirstOpenTime]
      ,[ContactClosedTime]
      ,[SkillsetName]
      ,[ContactStatus]
      ,[ClosedReasonCode]
      ,[ClosedReasonCodeID]
      ,[MailFrom]
      ,[MailTo]
      ,[OriginalSubject]
      ,[QueueType]
      ,[Source]
      ,[AgentLoginID]
      ,[Received]
      ,[MissingChats]
      ,[DatasetAdded]
      ,[PickUpTime]
      ,[ProcessingTime]
      ,[ResponseTime]
  FROM [dbo].[tblAvayaWebCom] where MailFrom like '$MailFrom'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Email,Skip,DB) values('$Q','$MailFrom', '$Skip','$database')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}


########################################


$Database = 'Sales'
Write-Host "Searching database $Database using $EmailFrom for strEmail or strEmailCRM" -ForegroundColor Cyan
   
$results = $null
$ready = 0
while ($ready -eq 0)
{
         
    $ans = Read-Host -Prompt "Use default email: $MailFrom Y/N"
    if($ans -eq 'Y'){$strEmail = $MailFrom} else {
        $strEmail = Read-Host -Prompt "strEmail w/ wildcard e.g. ax@abc.s%"

    }

   
$Query = @"
SELECT strEmail as Mail,strEmailCRM as MailCRM, *  FROM [dbo].[tbl_sal_ReportAIRCoupons]
  where strEmail like '$strEmail' or strEmailCRM like '$strEmail'
"@


$Results = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query 

$Results | Format-Table

$rr = Read-Host -Prompt "ready? Y/N"
    if ($rr -eq 'Y')
    {
       $ready = 1 
       $Apply = Read-host -prompt "Apply changes Y/N"
       if ($Apply -eq 'Y'){$Skip = 0} else {$Skip = 1}
    }

 }



if ($results -ne $null)
 {

$Q = @"
SELECT [ID]
      ,[datImportDate]
      ,[datImportADFDate]
      ,[strSign_Code]
      ,[strPNR_Rec_Loc]
      ,[intPrimaryTicket]
      ,[intTickNum_Org]
      ,[strSalesStatus]
      ,[strFB_Airline]
      ,[strFB_Status]
      ,[strFB_StatusType]
      ,[intFB_number]
      ,[strFSOrgAirCode]
      ,[strFSOrgAirName]
      ,[strFSDesAirCode]
      ,[strFSDesAirName]
      ,[strFareCalculation]
      ,[strFlightNumber]
      ,[strFlightDate]
      ,[strFlightSCCode]
      ,[strFlightServClass]
      ,[strFlightBCCode]
      ,[strFlightBooClass]
      ,[strOrigin]
      ,[strDestination]
      ,[strEmail]
      ,[strEmailCRM]
      ,[intNrCoupons]
      ,[strFileName]
      ,[bitInforcedExch]
      ,[bitFB]
      ,[bitVoidReported]
      ,[bitUpdateTable]
      ,[bitADF]
      ,[bitGroup]
  FROM [dbo].[tbl_sal_ReportAIRCoupons]
  where strEmail like '$strEmail' or strEmailCRM like '$strEmail'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Email,Skip,DB) values('$Q','$strEmail','$Skip','$Database')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}

######################################################


$Database = 'Sales'
Write-Host "Searching database $Database using $SurName for strSurName" -ForegroundColor Cyan
   
$results = $null
$ready = 0
while ($ready -eq 0)
{
         
    #$strSurName = Read-Host -Prompt "strSurName w/ wildcard e.g. hendr%"
    $strSurName  = $Surname

    $strGivenName = Read-Host -Prompt "strGivenName w/ wildcard e.g. han%"

   
$Query = @"
select strSurName as Sur,strGivenName as Given, *  FROM [dbo].[tbl_sal_ReportAIRIssues]
 where strSurName like '$strSurName' and strGivenName like '$strGivenName'
"@


$Results = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query 

$Results | Format-Table

$rr = Read-Host -Prompt "ready? Y/N"
    if ($rr -eq 'Y')
    {
       $ready = 1 
       $Apply = Read-host -prompt "Apply changes Y/N"
       if ($Apply -eq 'Y'){$Skip = 0} else {$Skip = 1}
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
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Givenname,Surname,Skip,DB) values('$Q','$strGivenName','$strSurName', '$Skip','$database')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}