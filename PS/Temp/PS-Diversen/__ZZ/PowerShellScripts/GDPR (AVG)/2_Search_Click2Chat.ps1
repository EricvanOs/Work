#Import-Module -Name SQLPS

$SQLServer = 'cyg7091'

# test Click2Chat

$Database = 'Click2Chat'

   
$results = $null
$ready = 0
while ($ready -eq 0)
{
         
    $MailFrom = Read-Host -Prompt "MailFrom w/ wildcard e.g. ax@abc.s%"

   
$Query = @"
SELECT mailFrom,* from dbo.tblAvayaWebCom where MailFrom like '$MailFrom'
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
insert DatabaseAdministrationReporting.dbo.GDPR(Query,Email) values(' $Q ',' $MailFrom ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query



$Q = @"
UPDATE [dbo].[tblAvayaWebCom] 
SET GDPR = 1, GDPR_Date = getdate()
where  MailFrom like '$MailFrom'
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

update [dbo].[tblAvayaWebCom] 
set MailFrom = @Random2 
where MailFrom like '$MailFrom'
"@

$Q = $Q -replace "'", "''"


$Query = @"
insert DatabaseAdministrationReporting.dbo.GDPR(Query) values(' $Q ')
"@

Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

}