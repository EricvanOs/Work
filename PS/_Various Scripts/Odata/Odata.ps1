<#
The difference is that OData is a specific protocol; REST is architecture style and design pattern. 
REST is a generic design technique used to describe how a web service can be accessed. 
Using REST you can make http requests to get data. ... OData is a specific technology that exposes data through REST.


https://www.odata.org/getting-started/understand-odata-in-6-steps/
#>

# JSON is case sensitive to both field names and data.

$url = "http://services.odata.org/v4/TripPinServiceRW/Airports"

$oOdata = Invoke-RestMethod -Uri $url

$oOdata.value

# retrieve the location

$oOdata.value.Location

# retrieve the city

$oOdata.value.Location.City


# mag ook op deze wijze

$baseurl = "http://services.odata.org"
$urlPathBase = "v4/TripPinServiceRW/"
$urlResourceName = "Airports"
$url = "${baseUrl}/${urlPathBase}/${urlResourceName}"
$oOdata = (invoke-webrequest ${url}).Content | ConvertFrom-Json

$oOdata.value