# https://github.com/EvotecIT/Mailozaurr

Import-Module Mailozaurr

Get-Command -Module Mailozaurr


$UserName = 'niks@xs4all.nl'
$Password = 'XZ=18CTI'


$Client = Connect-IMAP -Server 'imap.xs4all.nl' -Password $Password -UserName $UserName -Port 993  -Options Auto
$Client = Connect-POP3 -Server 'pop3.xs4all.nl' -Password $Password -UserName $UserName -Port 995 -Options Auto

Get-IMAPMessage -Client $Client

Get-POP3Message -Client $Client 

Send-EmailMessage -Server smtp.xs4all.nl -From niks@xs4all.nl  -To evanos@xs4all.nl -Subject 'test' -text 'een test'  -Port 465 -Username 'evanos' -Password 'XZ=18CTI'


#######################################################

$ClientID = '939333074185'
$ClientSecret = 'gk2ztAGU'

$CredentialOAuth2 = Connect-oAuthGoogle -ClientID $ClientID -ClientSecret $ClientSecret -GmailAccount 'evot@gmail.com'

Send-EmailMessage -From @{ Name = 'Przemysław Kłys'; Email = 'evot@gmail.com' } -To 'test@evotec.pl' `
    -Server 'smtp.gmail.com' -HTML $Body -Text $Text -DeliveryNotificationOption OnSuccess -Priority High `
    -Subject 'This is another test email' -SecureSocketOptions Auto -Credential $CredentialOAuth2 -oAuth


############################    


Import-Module .\Mailozaurr.psd1 -Force
Import-Module Microsoft.Graph.Authentication -Force

# this shows how to send email using combination of Mailozaurr and Microsoft.Graph to use Connect-MgGraph to authorize
$Body = EmailBody {
    New-HTMLText -Text "This is test of Connect-MGGraph functionality"
}

# authorize via Connect-MgGraph with delegated rights or any other supported method
Connect-MgGraph -Scopes Mail.Send

# sending email
$sendEmailMessageSplat = @{
    From           = 'przemyslaw.klys@test.pl'
    To             = 'przemyslaw.klys@test.pl'
    HTML           = $Body
    Subject        = 'This tests email as delegated'
    MgGraphRequest = $true
    Verbose        = $true
}
Send-EmailMessage @sendEmailMessageSplat






Save-POP3Message -Client $Client -Index 6 -Path "$Env:UserProfile\Desktop\mail.eml"
Disconnect-IMAP -Client $Client


get-help Send-EmailMessage

# https://docs.bettyblocks.com/en/articles/1012838-setting-up-google-oauth-2-0-authentication


$ClientID = '939333074185'
$ClientSecret = 'gk2ztAGU'

$CredentialOAuth2 = Connect-oAuthGoogle -ClientID $ClientID -ClientSecret $ClientSecret -GmailAccount 'evot@gmail.com'

Send-EmailMessage -From @{ Name = 'Przemysław Kłys'; Email = 'evot@gmail.com' } -To 'test@evotec.pl' `
    -Server 'smtp.gmail.com' -HTML $Body -Text $Text -DeliveryNotificationOption OnSuccess -Priority High `
    -Subject 'This is another test email' -SecureSocketOptions Auto -Credential $CredentialOAuth2 -oAuth