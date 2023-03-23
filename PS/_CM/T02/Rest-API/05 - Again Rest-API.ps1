# see: https://adamtheautomator.com/invoke-restmethod/


Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts"


# Store the API GET response in a variable ($Posts).
$Posts = Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts"

# Run the GetType() method against the first item in the array, identified by its index of 0.
$Posts[0].GetType()



# This will prompt for credentials and store them in a PSCredential object.
$Cred = Get-Credential


# Send a GET request including Basic authentication.
$Params = @{
	Uri = "https://jsonplaceholder.typicode.com/posts"
	Authentication = "Basic"
	Credential = $Cred
}

Invoke-RestMethod @Params


$Token = "123h1v23yt2egv1e1e1b2ei1ube2iu12be" | ConvertTo-SecureString -AsPlainText -Force


# Send a GET request including bearer authentication.
 $Params = @{
     Uri = "https://jsonplaceholder.typicode.com/posts"
     Authentication = "Bearer"
     Token = $Token
 }
 Invoke-RestMethod @Params


#open browser
https://jsonplaceholder.typicode.com/posts?userId=1&id=8


$Body = @{
    userId = 1
    id = 8
}
$Params = @{
	Method = "Get"
	Uri = "https://jsonplaceholder.typicode.com/posts"
	Body = $Body
}

Invoke-RestMethod @Params




$Body = @{
     title = "foo"
     body = "bar"
     userId = 1
 }
$JsonBody = $Body | ConvertTo-Json

# The ContentType will automatically be set to application/x-www-form-urlencoded for
# all POST requests, unless specified otherwise.
 $Params = @{
     Method = "Post"
     Uri = "https://jsonplaceholder.typicode.com/posts"
     Body = $JsonBody
     ContentType = "application/json"
 }
 Invoke-RestMethod @Params



$Form = @{
    title = "foo"
    body = "bar"
    userId = 1
}

$Params = @{
	Method = "Post"
	Uri = "https://jsonplaceholder.typicode.com/posts"
	Form = $Form
}

Invoke-RestMethod @Params



# Issue GET request to GitHub issues API for the PowerShell project repo and store
# the response headers in a variable ($Headers).
Invoke-RestMethod -Uri "https://api.github.com/repos/powershell/powershell/issues" -ResponseHeadersVariable "Headers"
# Print the $Headers variable to the console.
 $Headers


 $Params = @{
    Uri = "https://api.github.com/repos/powershell/powershell/issues"
      FollowRelLink = $true
      MaximumFollowRelLink = 3
  }
  Invoke-RestMethod @Params



  $Params = @{
    Uri = "https://api.github.com/repos/powershell/powershell/issues"
      FollowRelLink = $true
      MaximumFollowRelLink = 3
  }
  # Store the three pages of results in the $Results variable.
  $Results = Invoke-RestMethod @Params
  # Check that $Results contains three items (pages of issues from the GitHub issues API).
  $Results.Count
  # Check that the first item in the $Results array contains the first page of thirty issues.
  $Results[0].Count


# Invoke the request storing the session as MySession.
# The SessionVariable value shouldn't include a dollar sign ($).
Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts" -SessionVariable "MySession"

# Print the session object to the console.
$MySession

# Invoke the request using the session information stored in the $MySession variable.
Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts" -WebSession $MySession


# Print the $MySession variable to the console to demonstrate that the Credentials
# property is empty.
$MySession

# Override the session value by specifying the Credential parameter.
# In this example you will be prompted for the username and password.
$Params = @{
	Uri = "https://jsonplaceholder.typicode.com/posts"
	WebSession = $MySession
	Credential = (Get-Credential)
}

Invoke-RestMethod @Params

# Save post items to my-posts.json in the current directory.
Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts" -OutFile "my-posts.json"

# Print the contents of the JSON file to the console.
# ".\" in this command refers to the current working directory in your terminal session.
Get-Content -Path ".\my-posts.json"

# Save the response to "my-posts.json" and also in the $Posts variable using PassThru.
$Posts = Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts" -OutFile "my-posts.json" -PassThru

# Filter posts with 1 as the userId into a new variable ($User1Posts).
$User1Posts = $Posts.Where({$_.userId -eq 1})

# Import all posts from the "my-posts.json" file and store them in the $AllUserPosts variable.
$AllUserPosts = Get-Content -Path ".\my-posts.json" | ConvertFrom-Json

# Print the count of both variables to the console to demonstrate that they are different.
$User1Posts.Count
$AllUserPosts.Count

# Change location into your personal certificate store.
Set-Location "Cert:\CurrentUser\My\"

# Store the certificate with the thumbprint DDE2EC6DBFF56EE9C375A6073C97188ABAA4F5E4 in a variable ($Cert).
$Cert = Get-ChildItem | Where-Object {$_.Thumbprint -eq "DDE2EC6DBFF56EE9C375A6073C97188ABAA4F5E4"}

# Invoke the command using the client certificate.
Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts" -Certificate $Cert

# Restrict the request to only allow SSL/TLS 1.2 and 1.3 protocol versions.
Invoke-RestMethod -Uri "https://jsonplaceholder.typicode.com/posts" -SslProtocol @("Tls12", "Tls13")