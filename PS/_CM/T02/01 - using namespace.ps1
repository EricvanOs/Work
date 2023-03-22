using namespace System.Text
using namespace System.IO

[string]$string = "ก"
[byte[]]$stringbytes = [UnicodeEncoding]::Unicode.GetBytes($string)  # see: https://learn.microsoft.com/en-us/dotnet/api/system.text?view=net-7.0
                                                                     # https://www.unicode.org/cldr/cldr-aux/charts/22/transforms/Latin-Thai.html

[Stream]$memorystream = [MemoryStream]::new($stringbytes)            # see: https://learn.microsoft.com/en-us/dotnet/api/system.io?view=net-7.0
# Valid values are "SHA1", "SHA256", "SHA384", "SHA512", "MD5"
[string]$algorithm = "SHA256"
$hashfromstream = Get-FileHash -InputStream $memorystream -Algorithm $algorithm
$hashfromstream.Hash.ToString()