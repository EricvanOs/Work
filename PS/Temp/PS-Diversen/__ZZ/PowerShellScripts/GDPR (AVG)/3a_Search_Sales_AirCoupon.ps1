#Import-Module -Name SQLPS

$SQLServer = 'cyg7091'

# test Sales

$Database = 'Sales'

   
$results = $null
$ready = 0
while ($ready -eq 0)
{
         
    $strEmail = Read-Host -Prompt "MailFrom w/ wildcard e.g. ax@abc.s%"

   
$Query = @"
SELECT strEmail,strEmailCRM, *  FROM [dbo].[tbl_sal_ReportAIRCoupons]
  where strEmail like '$strEmail' or strEmailCRM like '$strEmail'
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
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Email) values(' $Q ',' $strEmail ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query



$Q = @"
UPDATE [dbo].[tbl_sal_ReportAIRCoupons] 
SET GDPR = 1, GDPR_Date = getdate()
where strEmail like '$strEmail' or strEmailCRM like '$strEmail'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query) values(' $Q ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query


# update MailFrom --> random string

$Q = @"
declare @random2 char(14)
declare @alphabet varchar(36) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
set @random2 =  
 substring(@alphabet, convert(int, rand()*36), 1) + 
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) + '@abc.here'

update [dbo].[tbl_sal_ReportAIRCoupons]  
set strEmail = @Random2, strEmailCRM = @Random2
where strEmail like '$strEmail' or strEmailCRM like '$strEmail'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query) values(' $Q ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}