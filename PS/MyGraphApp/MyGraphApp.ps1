# https://psmsgraph.readthedocs.io/en/latest/
<#
Create an Azure AD Application
1.Go to https://apps.dev.microsoft.com/
2.Register an app using your Office 365 or Azure AD account (the account must have permissions to add applications to you Azure AD)
3.Generate a new password for your app
4.Give the app the proper scope permissions
5.Set an arbitrary Redirect URI (e.g. https://localhost/)
6.Note your Redirect URI, Application ID, and the password that was generated. The Application ID is your "Client ID" and the password is your "Client Secret". These are not your O365/Azure username and password. 
#>




Install-Module -Name PSMSgraph 

#In the credential prompt, provide your application's Client ID as the username and Client Secret as the password
$ClientCredential = Get-Credential
$GraphAppParams = @{
    Name = 'My Graph Application!'
    ClientCredential = $ClientCredential
    RedirectUri = 'https://localhost/'
    Tenant = 'xHelios.onmicrosoft.com'

}
$GraphApp = New-GraphApplication @GraphAppParams
# This will prompt you to log in with your O365/Azure credentials. 
# This is required at least once to authorize the application to act on behalf of your account
# The username and password is not passed back to or stored by PowerShell.
$AuthCode = $GraphApp | Get-GraphOauthAuthorizationCode 
# see the following help for what resource to use. 
# get-help Get-GraphOauthAccessToken -Parameter Resource
$GraphAccessToken = $AuthCode | Get-GraphOauthAccessToken -Resource 'https://graph.windows.net'
$GraphAccessToken | Export-GraphOAuthAccessToken -Path 'k:\MyGraphApp\AccessToken.XML'


# Build a script to pull in all Azure AD users
Import-Module -name 'PSMSGraph'

$GraphAccessToken =  Import-GraphOAuthAccessToken -Path 'k:\MyGraphApp\AccessToken.XML'
$GraphAccessToken | Update-GraphOAuthAccessToken -Force

$AADUsers = Get-AADUserAll -AccessToken $GraphAccessToken
$AADUsers | 
    Select-Object -Property * -ExcludeProperty _AccessToken | 
    Export-Csv -Path 'k:\MyGraphApp\AADUsers.csv' -NoTypeInformation

$GraphAccessToken  | Export-GraphOAuthAccessToken -Path 'k:\MyGraphApp\AccessToken.XML'

