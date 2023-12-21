#Import-Module -Name SQLPS

$SQLServer = 'cyg7091'

# test Bluebizz
$Database = 'BlueBizz'

Write-Host "Searching database $Database (two tables Leads and LeadHist)" -ForegroundColor Cyan
$results = $null
$ready = 0
while ($ready -eq 0)
{
    
    $Surname = Read-Host -Prompt "Surname w/ wildcard e.g. hendriks%"

    $CompanyName  = Read-Host -Prompt "CompanyName"

$Query = @"
SELECT * from [dbo].[tblBLueBizzLeads] where Surname like '$Surname' and CompanyName like '$CompanyName'
union
SELECT * from [dbo].[tblBLueBizzLeadsHist] where Surname like '$Surname' and CompanyName like '$CompanyName'
"@


$Results = Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query 

$Results | Format-Table

$rr = Read-Host -Prompt "ready? Y/N"
    if ($rr  -eq 'Y')
    {
       $ready = 1 
    }

 }

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
union
SELECT * from [dbo].[tblBLueBizzLeadsHist] where Surname like '$Surname' and CompanyName like '$CompanyName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Surname,CompanyName) values(' $Q ',' $Surname' , ' $CompanyName ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query



$Q = @"
UPDATE [dbo].[tblBLueBizzLeads] 
SET GDPR = 1, GDPR_Date = getdate()
where Surname like '$Surname' and CompanyName like '$CompanyName';

UPDATE [dbo].[tblBLueBizzLeadsHist] 
SET GDPR = 1, GDPR_Date = getdate()
where Surname like '$Surname' and CompanyName like '$CompanyName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query) values(' $Q ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query


# update surname,email,telephone --> random string

$Q = @"
declare @random char(5)
declare @random2 char(14)
declare @random3 char(5)
declare @alphabet varchar(36) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
set @random =  
 substring(@alphabet, convert(int, rand()*36), 1) + 
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1);
set @random2 =  
 substring(@alphabet, convert(int, rand()*36), 1) + 
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) +
 substring(@alphabet, convert(int, rand()*36), 1) + '@abc.here'
set @alphabet = '0123456789'
set @random3 = 
 substring(@alphabet, convert(int, rand()*10), 1) + 
 substring(@alphabet, convert(int, rand()*10), 1) +
 substring(@alphabet, convert(int, rand()*10), 1) +
 substring(@alphabet, convert(int, rand()*10), 1) +
 substring(@alphabet, convert(int, rand()*10), 1);

update [dbo].[tblBLueBizzLeads] 
set Surname = @Random, Email=@Random2 , Telephone=@Random3
where Surname like '$Surname' and CompanyName like '$CompanyName';

update [dbo].[tblBLueBizzLeadsHist] 
set Surname = @Random, Email=@Random2 , Telephone=@Random3
where Surname like '$Surname' and CompanyName like '$CompanyName'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query) values(' $Q ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}