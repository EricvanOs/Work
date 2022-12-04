Login-PowerBI

# Only events per day (Could take 24 hours to showup)
# https://learn.microsoft.com/en-us/power-bi/admin/service-admin-auditing

$StartDateTime = '2022-12-04T00:00:00' 
$EndDateTime  =  '2022-12-04T23:59:59'

$activities = Get-PowerBIActivityEvent -StartDateTime $StartDateTime -EndDateTime $EndDateTime | ConvertFrom-Json

$activities.Count
$activities[0]