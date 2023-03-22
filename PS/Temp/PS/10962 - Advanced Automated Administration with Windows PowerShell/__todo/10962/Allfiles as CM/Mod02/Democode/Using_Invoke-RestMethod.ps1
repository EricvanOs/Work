
# auxiliary function generating the REST API header

function Get-AdminApiHeaders {
Param(
    $apiUrl
)

# Add .NET Framework type to handle the IIS Adminstration API untrusted certificate
If (-not ('ITrustACertificatePolicy' -as [type]))
{
Add-Type @" 
using System.Net; 
using System.Security.Cryptography.X509Certificates; 
public class ITrustACertificatePolicy : ICertificatePolicy { 
    public ITrustACertificatePolicy() {} 
    public bool CheckValidationResult( 
       ServicePoint sPoint, X509Certificate cert, 
       WebRequest wRequest, int certProb) { 
            return true;
       } 
} 
"@
}

# Instantiate the ITrustACerificatePolicy in the current session
[System.Net.ServicePointManager]::CertificatePolicy = New-Object ITrustACertificatePolicy

$iisAdminApiResp1 = Invoke-WebRequest -Uri "$apiUrl/security/api-keys" `
				      -UseDefaultCredentials `
                                      -SessionVariable session 

$xsrfTokenHeader = $iisAdminApiResp1.Headers."XSRF-TOKEN"
$xsrfTokenHash = @{}
$xsrfTokenHash."XSRF-TOKEN" = $xsrfTokenHeader

$iisAdminApiResp2 = Invoke-WebRequest -Uri "$apiUrl/security/api-keys" `
                                      -UseDefaultCredentials `
				      -Headers $xsrfTokenHash `
				      -Method Post `
				      -ContentType "application/json" `
                                      -WebSession $session `
				      -Body '{"expires_on": ""}'

$resp2Content = ConvertFrom-Json ([System.Text.Encoding]::UTF8.GetString($iisAdminApiResp2.content))
$accessToken = $resp2Content.access_token
$accessTokenHash = @{}
$accessTokenHash."Access-Token" = "Bearer $accessToken"
$accessTokenHash."Accept" = "application/hal+json"

return $accessTokenHash

} #end function Get-AdminApiHeaders

$computerName = 'lon-svr1.adatum.com'
$apiUrl = "https://$($computerName):55539"
$headers = Get-AdminApiHeaders -apiUrl $apiUrl

Write-Output -PSObject $headers




############## Beginning of the demo ##################
# enumerate existing web sites and app pools on LON-SVR1
#######################################################

$iisAdminApiWebSites = Invoke-RestMethod -Uri "$apiUrl/api/webserver/websites" `
                                      	 -UseDefaultCredentials `
					 -Headers $headers `
					 -Method Get `
					 -ContentType "application/json"

$iisAdminApiWebSites | ConvertTo-Json

$iisAdminApiAppPools = Invoke-RestMethod -Uri "$apiUrl/api/webserver/application-pools" `
					 -UseDefaultCredentials `
					 -Headers $headers `
                                      	 -Method Get `
					 -ContentType "application/json" 

$iisAdminApiAppPools | ConvertTo-Json
