function New-HeliosSecret {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$Name,

        [Parameter(Mandatory=$True)]
        [string]$secret
    )

    Open-HeliosVault

    if ((Get-SecretInfo -Name $Name).Count -eq 1) { 
        Write-Host 'Secret already exists' 
    }
    else {
        Set-Secret -Name $name -Secret $secret
    }    


    Close-HeliosVault

}


