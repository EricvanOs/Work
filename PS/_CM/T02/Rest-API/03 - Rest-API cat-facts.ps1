$endpointUri = 'https://alexwohlbruck.github.io/cat-facts/'

(Invoke-WebRequest -Uri $endpointUri).Content 

# or no authentication
Invoke-RestMethod -Uri $endpointUri 


# or with authentication (not needed in this case)

$token = 'xxxxxxxxxxxxxxxx' # if token is necessary
$params = @{
    Uri         = 'https://alexwohlbruck.github.io/cat-facts/'
    Headers     = @{ 'Authorization' = "Bearer $token" }
    Method      = 'GET'
    Body        = $jsonSample
    ContentType = 'application/json'
}

Invoke-RestMethod @params



