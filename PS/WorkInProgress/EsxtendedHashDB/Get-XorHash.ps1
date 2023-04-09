function Get-XorHash {
<#
.SYNOPSIS
Retrieves Xor Hash of given folder structure.
.DESCRIPTION
Retrieves Xor Hash of given folder structure.
.PARAMETER Path
The path name.
.PARAMETER Algorithm
The type of algorithm to use eg MD5, SHA1, etc
.EXAMPLE
.\Get-Xorhash -Path 'c:\temp' -Algorithm 'MD5' -Verbose
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string]
    $Path,

    [parameter()]
    [ValidateSet('MD5', 'SHA1', 'SHA256')]
    [String]
    $Algorithm = 'MD5'
)

Push-Location 

Set-Location $Path

$files = Get-ChildItem  -File  -Recurse

$hashes = $files | Get-FileHash -Algorithm $Algorithm

#MD5 --> $bhash[0..3]  --> 4 * 32bits

switch ($Algorithm)
{       
  'MD5'   {$imx = 4}       
  'SHA1'  {$imx = 5}
  'SHA256'{$imx = 8}        
}

$bhash = @(0,0,0,0,0,0,0,0);

for ($i = 0; $i -lt 8; $i++)
{ 
  $bhash[$i] = [uint32]0;  
}


foreach($hash in $hashes){
    # hexstring -> 8 hex , 8 hex, ... --> int 
    
    for ($i = 0; $i -lt $imx; $i++)
        { 
        $bhash[$i] = $bhash[$i] -bxor ([uint32]('0x' + $hash.hash.substring(8*$i,8)))
        }
}


$xorhash=''
for ($i = 0; $i -lt $imx; $i++)
{ 
   $xorhash = $xorhash + "{0:X0}" -f $bhash[$i] 
}

$xorhash

Pop-Location

}






