<#  Already done
    # once save pfx-password in vault, applicationid also
    # create selfsigned cert
    # export to cer,pfx-file 

    #import cer-file in azure
    #import pfx-file on machine
#>

Open-HeliosVault 
$vault = 'ScriptingVault'
# Read secrets from vault 
$TenantId = (Get-Secret -Name TenantID -Vault $vault -AsPlainText) 
$ApplicationId = (Get-Secret -Name MSGraphMail-ApplicationID -Vault $vault -AsPlainText)
Close-HeliosVault

$thumbprint = (Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=MSGraphMail'}).Thumbprint




# Authenticate and connect to Microsoft Graph
Connect-MgGraph `
-ClientId $ApplicationId `
-TenantId $TenantId `
-CertificateThumbprint $thumbprint


# get context
Get-MgContext

# compose message
$mailParams = @{
    Message = @{
     Subject = "Server Disk Space on COMPUTER_A is below the 30% Threshold."
        Body = @{
            ContentType = "Text"
            Content = "The remaining available diskspace on [C:] is now at 5GB. Please do something."
        }
        ToRecipients = @(
        @{
        EmailAddress = @{
            Address = "evanos@in-li.eu"
        }
        }
        )
    }
 }

 # send mail
 Send-MgUserMail -UserId 'ericvanos@xhelios.onmicrosoft.com' -BodyParameter $mailParams


 ######################## easier to read
$Subject = "Server Disk Space on COMPUTER_A is below the 30% Threshold."
$Body = @{
    ContentType = "Text"
    Content = "The remaining available diskspace on [C:] is now at 5GB. Please do something."
}
$ToRecipients = @(
    @{
        EmailAddress = @{
            Address = "evanos@in-li.eu"
        }
    }
    @{
        EmailAddress = @{
            Address = "evanos@xs4all.nl"
        }
    }
)
<# idem for CC and BCC
$CCRecipients
$BCCRecipients
Attachments
#>
$mailParams = @{
    Message = @{
     Subject = $Subject
     Body = $Body
     ToRecipients = $ToRecipients
    }
 }
########################

# add attachment
# convert to Base64
$filepath = '\\pantheon\data\misc\PowerShell-Scripts\Nested Hyper-V Settings.txt'
$f = [convert]::ToBase64String((Get-Content $filepath -AsByteStream))

$Attachments = @(
    @{
    "@odata.type" = "#microsoft.graph.fileAttachment"
    "name" = "LoremIpsum.txt"
    "contentBytes" = $($f)
 }
)

#again send mail with attachments

$mailParams = @{
    Message = @{
     Subject = $Subject
     Body = $Body
     ToRecipients = $ToRecipients
     Attachments = $Attachments
    }
 }

  # send mail
  Send-MgUserMail -UserId 'ericvanos@xhelios.onmicrosoft.com' -BodyParameter $mailParams