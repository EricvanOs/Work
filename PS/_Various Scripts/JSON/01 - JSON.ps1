$json=@"
 {
    "SiteType":  {
                       "External":  "Http://External.PowerShellDistrict.com" ,
                       "Internal":  "Http://Internal.PowerShellDistrict.com" 
                   },
	"Author": [{
				Name:"Stephane van Gulick",
				Age:"Can't remember..",
				City:"Basel",
				Country:"Switzerland",
				FavoriteColor:"Orange"
			},
			{
				Name:"Wappi",
				Age:"69",
				City:"Strasbourg",
				Country:"France",
				FavoriteColor:"Transparent"
			}
			]
	
}
"@

#test 
Test-Json $json

$aa =  ConvertFrom-JSON -InputObject $json  # or  $json | ConvertFrom-JSON
$aa | Get-Member
$aa.Author 
$aa.Author.City
$aa.Author[0]
$aa.Author[0].City


## convert to JSON

$injson = Get-Process |Where-Object{$_.name -like 'winpty*'} | Select-Object -property	Handles,ProcessName, Id  | ConvertTo-Json
$injson

# https://petri.com/how-to-use-powershell-7-to-work-with-json-files/
