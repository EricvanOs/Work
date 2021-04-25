import-module sqlserver

Get-PSDrive

Set-Location sqlserver:\

Set-Location SQLSERVER:\sql\eos\default\logins

Set-Location c:\



$sql = 'Clio'
Push-Location SQLSERVER:\sql\$sql\default\logins

$winlogins = Get-ChildItem | Where-Object{$_.loginType -like "Windows*" }

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

Pop-Location


