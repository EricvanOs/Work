# get codesigning certificate
$cert =  Get-ChildItem -Path "Cert:\CurrentUser\My" -CodeSigningCert

# sign ps1-file
Set-AuthenticodeSignature -FilePath 'K:\_CM\H08\Signing_Test.ps1' -Certificate $cert

Get-AuthenticodeSignature -FilePath 'K:\_CM\H08\Signing_Test.ps1'  

# change file, test again
Get-AuthenticodeSignature -FilePath 'K:\_CM\H08\Signing_Test.ps1' 

<#
# change execution policy

Set-ExecutionPolicy -ExecutionPolicy AllSigned 

Get-ExecutionPolicy -List

run script .\abc.ps1

change script

run again --> will fail

#>



# function for removing Signature

function Remove-Signature
{
    [cmdletbinding()]

    Param(
        [Parameter(Mandatory = $False,Position = 0,ValueFromPipeline = $True,ValueFromPipelineByPropertyName = $True)]
        [Alias('Path')]
        [system.io.fileinfo[]]$FilePath
    )

    Begin{
        Push-Location -Path $env:USERPROFILE
    }

    Process{
        $FilePath |
        ForEach-Object -Process {
            $Item = $_
			
            If($Item.Extension -match '\.ps1|\.psm1|\.psd1|\.ps1xml')
            {
                Try
                {
                    $Content = Get-Content -Path $Item.FullName -ErrorAction Stop
    
                    $StringBuilder = New-Object -TypeName System.Text.StringBuilder -ErrorAction Stop
    
                    Foreach($Line in $Content)
                    {
                        If($Line -match '^# SIG # Begin signature block|^<!-- SIG # Begin signature block -->')
                        {
                            Break
                        }
                        Else
                        {
                            $null = $StringBuilder.AppendLine($Line)
                        }
                    }
    
                    Set-Content -Path $Item.FullName -Value $StringBuilder.ToString()
                }
                Catch
                {
                    Write-Error -Message $_.Exception.Message
                }
            }
        }
    }

    End{
        Pop-Location
    }
}


# now use it

Remove-Signature -FilePath K:\_CM\H08\Signing_Test.ps1