# keep in mind this not 100%

function Get-ExtendedDate{
  $a = Get-Date
  Add-Member -MemberType scriptmethod -Name GetWeekOfYear -Value {Get-Date -UFormat %V} -InputObject $a
  $a
} #end function Get-ExtendedDate


Get-ExtendedDate | Get-Member


(Get-ExtendedDate).getWeekOfYear()


$b = Get-ExtendedDate
$b.GetWeekOfYear()
"Today is $($b.ToShortDateString())"
"There are $(365 - $($b.DayOfYear)) days left in the year."