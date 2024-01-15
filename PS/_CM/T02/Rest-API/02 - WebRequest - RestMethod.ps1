# Difference betwween Invoke-WebRequest and Invoke-RestMethod
<#
Invoke-RestMethod is perfect for quick APIs that have no special response information such as Headers or Status Codes, 
whereas Invoke-WebRequest gives you full access to the Response object and all the details it provides.
#>

Invoke-WebRequest 'https://jsonplaceholder.typicode.com/todos/1'

Invoke-RestMethod 'https://jsonplaceholder.typicode.com/todos/1'
Invoke-RestMethod 'https://jsonplaceholder.typicode.com/posts' -Method Post -Body @{title="test post";user=2}

$param = @{
    Uri     = 'https://jsonplaceholder.typicode.com/posts'
    Body    = @{ title = "Test" }
    Method  = "Post"
}
Invoke-RestMethod @param -Headers @{ Accept = "application/json" }

(Invoke-RestMethod https://jsonplaceholder.typicode.com/todos/1 -Method Get).Title


# scraping a web-site
(Invoke-WebRequest www.google.com).links.href