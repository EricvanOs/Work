function Import-Namespace
{
    param(
        [Parameter(Position=0, Mandatory=$true)] [string] $Namespace ,
        [Parameter(Position=1, Mandatory=$false)][string] $AssemblyName = "mscorlib"
    )   

    process {
        $types = New-Object psobject           
        $assembly = [System.Reflection.Assembly]::LoadWithPartialName($AssemblyName)
        $assembly.GetTypes() |
            Where-Object { $_.NameSpace -eq $Namespace `
                            -and $_.IsPublic `
                            -and -not $_.IsAbstract `
                            -and -not $_.IsSubClassOf([System.Exception]) } |
            ForEach-Object {
                Add-Member -MemberType NoteProperty -Name $_.Name -Value $_ -InputObject $types
            }
        return $types
    }   
}

 



$crypto = Import-Namespace "System.Security.Cryptography"
$bytes = (New-Object System.Text.ASCIIEncoding).GetBytes("Hello World")

$sha1 = New-Object $crypto.SHA1Managed
$hash = $sha1.ComputeHash($bytes)
"$hash"

$rsa = New-Object $crypto.RSACryptoServiceProvider
$fmtr = New-Object $crypto.RSAPKCS1SignatureFormatter $rsa
$fmtr.SetHashAlgorithm("SHA1")

$signtr = $fmtr.CreateSignature($hash)
"$signtr"