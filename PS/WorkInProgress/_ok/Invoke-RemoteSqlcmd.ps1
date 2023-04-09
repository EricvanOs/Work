Function Invoke-RemoteSqlcmd {
Param (
[string]$ComputerName,
[string]$sqlcmd
)

 Invoke-Command -ComputerName $ComputerName -ScriptBlock{param($x)
 Invoke-Sqlcmd -Query $x
} -ArgumentList $sqlcmd
}

$quote = Invoke-RemoteSqlcmd -ComputerName hypnos -sqlcmd 'exec quotes.dbo.spQuote'
$quote[0].column1 | out-file -FilePath 'C:\Utils\BGInfo\quote.txt' -encoding ASCII 


$sqlcmd = "exec DomainAdministration.dbo.mythology '$env:computername' "
$mythology = Invoke-RemoteSqlcmd -ComputerName hypnos -sqlcmd $sqlcmd
$mythology[0].column1 | out-file -FilePath 'C:\Utils\BGInfo\mythology.txt' -encoding ASCII