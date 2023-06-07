function Get-SQLErrorLogs{
  param
  (
  [Parameter(Position=0,Mandatory=$true)]
  [alias('instance')]
  [string]$instanceName
  )
  # import module if needed
  If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

  #replace this with your instance name
  $server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
  Write-Output $server.ReadErrorLog()
}


# Sample function call:
Get-SQLErrorLogs -instanceName 'echo.pantheon.somewhere' |
  Where-Object LogDate -gt (Get-Date).AddDays(-2)


# information about function
Get-SQLErrorLogs -instanceName 'echo.pantheon.somewhere' | Get-Member

