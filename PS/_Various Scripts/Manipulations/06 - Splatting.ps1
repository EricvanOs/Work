get-help Get-ChildItem -ShowWindow

$Data = @{Path="C:\"; Hidden=$True; Recurse=$False} #hashtable (value pairs)
Get-ChildItem @Data


$Data = @{
  ServerInstance='clio.pantheon.somewhere'
  Database = 'Quotes'
  Query = @" 
select top(3) QText from Quote
"@
}

Invoke-Sqlcmd @Data

# combination of parameters and splatting
$Query = @' 
select QText from Quote
'@
$Data = @{ServerInstance='clio.pantheon.somewhere'
          Database = 'Quotes'
}

Invoke-Sqlcmd  @Data -Query $Query