Invoke-WebRequest https://blogs.technet.microsoft.com/heyscriptingguy/ -UseBasicParsing

Invoke-WebRequest https://blogs.technet.microsoft.com/heyscriptingguy/  -Method OPTIONS  |  Select-Object -ExpandProperty Headers


Invoke-WebRequest https://expired.badssl.com/

Invoke-WebRequest https://expired.badssl.com/ -SkipCertificateCheck  # available in  >= .net 7.0






########### If you want to use in PS 5.1
Class AcceptAllPolicy: System.Net.ICertificatePolicy {
    [Boolean] CheckValidationResult(
        [System.Net.ServicePoint] $servicePoint,
        [System.Security.Cryptography.X509Certificates.X509Certificate]
        $certificate,
        [System.Net.WebRequest] $webRequest,
        [Int32] $problem
        ) {
        return $true
        }
    }
    [System.Net.ServicePointManager]::CertificatePolicy =  [AcceptAllPolicy]::new()
    
Invoke-WebRequest "https://expired.badssl.com/"
######################
