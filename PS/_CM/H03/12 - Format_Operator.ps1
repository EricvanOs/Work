<#
The syntax for -F format operator is

{<index>[,<alignment>][:<formatString>]}

Format Strings  Description  
C Currency 
X Display Number in Hexa Decimal 
p Display Number as Percentage 
n Display with width n to left side 
-n Display with width -n to right side 
dn Display Numbers Padded by 0 by n times 
# Digit placeholder, 
, Thousand separator 
\ Escape Character 
:ddd Day of Week 
:dd Day of Month 
:dddd Full name of Day of Week 
:hh Hour 
:HH Hour in 24 Hour format 
:mm Minutes 
:SS Seconds 
:MM Month in Number 
:MMMM Name of the Month 
:yy Year in short 
:yyyy Full year 
#>


'{0:C} {1:C} ## {2:C} !! {1:N3}'  -f 200,99,765

'{0:p}' -f .703

'{0:d7}' -f 19

'{0:###-##-##}' -f 8976203

'{0:ddd}' -f (get-date)

'{0:dd}' -f (get-date)

'{0:dddd}' -f (get-date)

'{0:hh}' -f (get-date)

'{0:mm}' -f (get-date)

'{0:MM}' -f (get-date)

'{0:MMMM}' -f (get-date)

'{0:yy}' -f (get-date)

'{0:yyyy}' -f (get-date)

'{0:#,#}' -f 100980243

# in a loop
$procs = Get-Process
foreach ($proc in $procs) {}
$proc
'{0,20} {1,40}' -f $proc.ProcessName , $proc.vm
'{0,-20} {1,40}' -f $proc.ProcessName , $proc.vm



$procs = Get-Process
foreach ($proc in $procs) {

  '{0,20} {1,40}' -f $proc.ProcessName , $proc.vm
  
}

#left alignment for first column
$procs = Get-Process
foreach ($proc in $procs) {

  '{0,-20} {1,40}' -f $proc.ProcessName , $proc.vm
  
}


# mag ook zo
get-process 
| Where-Object{$_.name -like '*sql*'} 
| Format-Table -Property Name, ID, VM, @{Label        = 'VM(GB)';
                                         Expression   = {$_.VM /1GB};
                                         FormatString = 'N2';
                                         Align        = 'right'}    