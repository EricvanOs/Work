
using assembly 'C:\Program Files\PackageManagement\NuGet\Packages\YamlDotNet.13.0.2\lib\net7.0\YamlDotNet.dll'
using namespace YamlDotNet

# see: https://github.com/aaubry/YamlDotNet/wiki/Serialization.Serializer

$yamlSerializer = [Serialization.Serializer]::new()

$info = [ordered]@{
  Inventory = @(
    @{ Name = 'Apples' ; Count = 1234 }
    @{ Name = 'Bagels' ; Count = 5678 }
  )
    CheckedAt = [datetime]'2023-01-01T01:01:01'
}

$yamlSerializer.Serialize($info)



# meta information 
[Serialization.Serializer].Getmembers()
[Serialization.Serializer] | Get-Member -Static

$yamlSerializer | Get-Member

