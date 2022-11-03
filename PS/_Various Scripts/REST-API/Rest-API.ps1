$endpointUri = 'https://cat-fact.herokuapp.com/facts'

(Invoke-WebRequest -Uri $endpointUri).Content # niet echt leesbare informatie

# aanzienlijk beter
Invoke-RestMethod -Uri $endpointUri  -Headers @{ 'Authentication' = 'Bearer xxxxxxxxxxxxxxxx'  }


# or

$token = 'xxxxxxxxxxxxxxxx' # if token is necessary
$params = @{
    Uri         = 'https://cat-fact.herokuapp.com/facts'
    Headers     = @{ 'Authorization' = "Bearer $token" }
    Method      = 'GET'
    Body        = $jsonSample
    ContentType = 'application/json'
}

Invoke-RestMethod @params



