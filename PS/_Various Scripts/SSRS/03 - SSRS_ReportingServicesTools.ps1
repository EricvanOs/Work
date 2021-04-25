# install-module -name ReportingServicesTools

# https://www.mssqltips.com/sqlservertip/4738/powershell-commands-for-sql-server-reporting-services/

get-command -Module ReportingServicesTools


Get-RsFolderContent -ReportServerUri https://selene.pantheon.somewhere/reportserver -Path /Charts |             
Format-Table -AutoSize


