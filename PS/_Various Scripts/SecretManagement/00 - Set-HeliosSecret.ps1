function Set-HeliosSecret {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$Name,

        [Parameter(Mandatory=$True)]
        [string]$NewSecret
    )

    Open-HeliosVault

    if ((Get-SecretInfo -Name $Name).Count -eq 0) { 
        Write-Host 'Secret does not exists' 
    }
    else {
        Remove-Secret -Name $name
        Set-Secret -Name $Name -Secret $NewSecret -Vault ScriptingVault
    }    


    Close-HeliosVault

}
    