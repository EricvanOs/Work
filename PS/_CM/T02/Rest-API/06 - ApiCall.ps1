# force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


# see: https://www.metaweather.com/api/


$Params = @{
    "URI" = 'https://www.metaweather.com/api/location/44418/'
}

Invoke-WebRequest @Params


$Params = @{
"URI"    = 'https://www.metaweather.com/api/location/44418/'
"Method" = 'GET'
}

Invoke-RestMethod @Params


$Params = @{
"URI"    = 'https://www.metaweather.com/api/location/search/?query=london'
"Method" = 'GET'
}
Invoke-RestMethod @Params


$Params = @{
"URI"    = 'https://www.metaweather.com/api/location/44418/2013/4/27/'
"Method" = 'GET'
}
Invoke-RestMethod @Params


Invoke-WebRequest -Uri https://apod.nasa.gov/apod/



https://zappysys.com/blog/call-rest-api-powershell-script-export-json-csv/


Install-Module -Name SalesforceCmdlets 

jbmurphy -- connecting to the salesforce restapi with powershell


# [ordered] type accelerator next to the variable to hold the ordered dictionary

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tokenurl = "https://InstanceName-dev-ed.my.salesforce.com/services/oauth2/token"
$postParams = [ordered]@{
grant_type="password";
client_id="ReallyLongClientIDReallyLongClientIDReallyLongClientIDReallyLongClientIDReallyLongCli";
client_secret="1234567890123456789";
username="bob@aol.com";
password="PasswordAndTokenNoSpaces";
}

$access_token=(Invoke-RestMethod -Uri $tokenurl -Method POST -Body $postParams).access_token

$url = "https://InstanceName-dev-ed.my.salesforce.com/services/data/v37.0/sobjects/Account"
Invoke-RestMethod -Uri $url -Headers @{Authorization = "Bearer " + $access_token}


#letop salesforce gebruikt SOQL (niet sql)