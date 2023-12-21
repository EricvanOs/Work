#Import-Module -Name SQLPS

$SQLServer = 'cyg7091'

# cleanup
Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "delete from GDPR where skip = 1"

# generate random info
$randSurName = -join ((65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})
$randEmail = -join ((65..90) + (97..122) | Get-Random -Count 10  | % {[char]$_}) + '@abc.com'
$randTelephone = -join ((48..57) | Get-Random -Count 10 | % {[char]$_})


$id = 1
$idmax = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select max(ID) from GDPR").Column1
while ($id -le $idmax) {

$q = Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select query from gdpr where id= $ID"

if ($q -ne $null){ 

    $database = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select db from gdpr where id = $ID").db


    if($database -eq 'BlueBizz') {
    
        if ($q.query -match "tblBlueBizzLeads") { 
    
    
        # read params 
        $SurName = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select surname from gdpr where id = $ID").surname
        $companyName = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select CompanyName from gdpr where id = $ID").CompanyName

        #action
    
        $Query = @"
        UPDATE [dbo].[tblBLueBizzLeads] 
        SET GDPR = 1, GDPR_Date = getdate()
        where Surname like '$Surname' and CompanyName like '$CompanyName';
"@

        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

        $Query = @"
        update [dbo].[tblBLueBizzLeads] 
        set Surname = '$randSurName', Email='$randEmail' , Telephone='$randTelephone'
        where Surname like '$Surname' and CompanyName like '$CompanyName';
"@


        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

        }
   
        if ($q.query -match "tblBlueBizzLeads_Hist") { 
    
    
        # read params 
        $SurName = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select surname from gdpr where id = $ID").surname
        $companyName = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select CompanyName from gdpr where id = $ID").CompanyName

        $Query = @"
        UPDATE [dbo].[tblBLueBizzLeads_Hist] 
        SET GDPR = 1, GDPR_Date = getdate()
        where Surname like '$Surname' and CompanyName like '$CompanyName'
"@

        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query


        $Query = @"
        update [dbo].[tblBLueBizzLeads_Hist] 
        set Surname = '$randSurName', Email='$randEmail' , Telephone='$randTelephone'
        where Surname like '$Surname' and CompanyName like '$CompanyName'
"@

        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query
        }
    }


    ############### next DB

    if($database -eq 'Click2Chat') {
    # read params 
    $MailFrom = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select Email from gdpr where id = $ID").Email

    #action
    $Query = @"
    UPDATE [dbo].[tblAvayaWebCom] 
    SET GDPR = 1, GDPR_Date = getdate()
    where MailFrom like '$MailFrom'
"@

    Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query

    
    $Query = @"
    update [dbo].[tblAvayaWebCom] 
    set MailFrom = '$randEmail'
    where MailFrom like '$MailFrom'
"@

    Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query
    }   
      
    ############### next DB
      
    if($database -eq 'Sales') {

        if ($q.query -match "tbl_sal_ReportAIRCoupons") { 
        # read params 
        $strEmail = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select Email from gdpr where id = $ID").Email
        #action
        $Query = @"
        UPDATE [dbo].[tbl_sal_ReportAIRCoupons] 
        SET GDPR = 1, GDPR_Date = getdate()
        where strEmail like '$strEmail' or strEmailCRM like '$strEmail'
"@

        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query


        $Query = @"
        update [dbo].[tbl_sal_ReportAIRCoupons]  
        set strEmail = '$randEmail', strEmailCRM = '$randEmail'
        where strEmail like '$strEmail' or strEmailCRM like '$strEmail'
"@

        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query
                }
    
        if ($q.query -match "tbl_sal_ReportAIRCIssues") { 
        # read params 
        $strSurName = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select SurName from gdpr where id = $ID").SurName
        $strGivenName = (Invoke-Sqlcmd -ServerInstance $SQLServer -Database 'DatabaseAdministrationReporting' -Query "select GivenName from gdpr where id = $ID").GivenName
        #action
        $Query = @"
        UPDATE [dbo].[tbl_sal_ReportAIRIssues] 
        SET GDPR = 1, GDPR_Date = getdate()
        where strSurName like '$strSurName' and strGivenName like '$strGivenName'
"@

        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query


        $Query = @"
        update [dbo].[tbl_sal_ReportAIRIssues]   
        set strSurName = '$randSurName'
        where strSurName like '$strSurName' and strGivenName like '$strGivenName'
"@

        Invoke-Sqlcmd -ServerInstance $SQLServer -Database $Database -Query $Query
        }


    }



}
$id = $id + 1
}
}