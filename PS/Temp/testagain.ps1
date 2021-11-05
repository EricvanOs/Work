# lost columns? / properties

Get-Module -ListAvailable  # a column PSEdition is available

# let's try it
Get-Module -ListAvailable | Select-Object -Property Name, PSEdition

# let's have a look at all properties
Get-Module -ListAvailable | get-member

# We have to use CompatiblePSEditions
Get-Module -ListAvailable | Select-Object -Property Name, CompatiblePSEditions



$object = Get-Module -ListAvailable | Where-Object{$_.name -eq 'PSDiagnostics'}

($object).PSStandardMembers.DefaultDisplayPropertySet

($object).PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames