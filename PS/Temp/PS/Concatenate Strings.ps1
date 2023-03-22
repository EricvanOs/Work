
$year = 2022
Write-Host $("Year " + $year)

# Below script will also work

$year = 2022
$str = "Year " + $year
Write-Host $str



$year = 2022
Write-Host "Year $year"



$year = 2022
$month = "December"
Write-Host 'Year'$year', Month '$month



$year = 2022
$month = "December"
Write-Host (-join("Year ", $year, ", Month ", $month))



$year = 2022
$month = "December"
Write-Host ("Year {0}, Month {1}" -f $year, $month)



$year = 2022
$month = "December"
Write-Host ([string]::Format("Year {0}, Month {1}", $year, $month))
