Function Get-Quote{
  Param(
    [Parameter(Mandatory=$true)]
    [string]$ComputerName
  )

   Invoke-Command -ComputerName $ComputerName -ScriptBlock{
    (Invoke-Sqlcmd -Query 'exec quotes.dbo.spQuote').column1
   }
}


# using function
Get-Quote -ComputerName clio 

