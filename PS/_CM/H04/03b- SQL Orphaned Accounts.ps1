$sql = 'Clio'

Import-Module sqlserver  # needed for PSDrive

Push-Location SQLSERVER:\sql\$sql\default\logins
$winlogins = Get-ChildItem | Where-Object{$_.loginType -like "Windows*" }
Pop-Location

## solution #1

foreach ($winlogin in $winlogins)
{
  if ($winlogin.name.Substring(0,$winlogin.name.IndexOf('\')) -in ('NT SERVICE','NT AUTHORITY','BUILTIN')){
    continue
  }

  $cnt = (
          Get-ADObject -Filter {(ObjectClass -eq 'user') -or (ObjectClass -eq 'computer')}  | 
          Where-Object{$_.Name -eq (($winlogin.Name).toUpper().Replace('PANTHEON\','').Replace('$','')) } | 
          Measure-Object 
        ).Count

  if ($cnt -eq 0 )  #no corresponding account in AD
  {
      write-host "Following count : $($winlogin.name) does not exists any more in AD"
  } 
}

# solution #2 using regular expressions

foreach ($winlogin in $winlogins)
{
  if ($winlogin.name -match  'NT SERVICE|NT AUTHORITY|BUILTIN'){continue}  # these accounts are skipped

  $cnt = (
  Get-ADObject -Filter {(ObjectClass -eq 'user') -or (ObjectClass -eq 'computer' -or (ObjectClass -eq 'group') )} |
  Where-Object{ $winlogin.Name -match  $_.name } |
  Measure-Object
  ).count
  
  if ($cnt -eq 0 )  #no corresponding account in AD
  {
      write-host "Following count : $($winlogin.name) does not exists any more in AD"
  } 

}


