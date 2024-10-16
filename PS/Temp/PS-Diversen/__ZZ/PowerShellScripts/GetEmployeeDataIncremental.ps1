
<#
	.AUTHOR
		Marco Baars

	.MAIL
		marco.baars@cygnific.com

	.PURPOSE
		Collect export files from Profit connectors

	.DATE
		24-11-2016

	.VERSION
		1.0 - 24-11-2016 MBa

#>

cls

#region create variables

# Define the profit connectors that should be retreived data from
$GetConnectors = @("iPublications_Employee","iPublications_EmployeeBI","iPublications_Course_Skill_Management_Languages", `
                     "iPublications_Organigram","iPublications_EmployeeAll")

# Define path where files should be stored
#$DestinationPath = "\\cyg7089\SQL Integration Services\FileSource\HRM"
$DestinationPath = "\\cyg7091\SQL Integration Services\FileSource\HRM"

# Empty the destination folder before retreiving the files
Get-ChildItem -Path $DestinationPath\* -Include *.XML | foreach { $_.Delete()}

# Define webservice URL
$ProfitServicesAppConnector = New-WebServiceProxy -uri "https://43340.afasonlineconnector.nl/profitservices/appconnectorget.asmx?WSDL"

#endregion

#region Define access token

#---------------------------------------------------------------------------------------------------------------------------#
# Uncomment and execute this script part to create the encrypted credentials
# Keep in mind that the created strings are created in the context of the 
# current user and computer and do NOT work with other user/computer
# Encrypted string is displayed. Copy/paste it in the variable $TokenEncrypted

# Replace with required token
#$Token = "<token><version>1</version><data>845F931BE0284FD08C1EE65C7FDBBF70B025A6634D305DFC5C732ABE3E1D6A15</data></token>"

# Display encrypted string. Put those string in the $TokenEncrypted variable
#$Token | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
#---------------------------------------------------------------------------------------------------------------------------#

# Encrypted logon credentials for Profit
$TokenEncrypted = "01000000d08c9ddf0115d1118c7a00c04fc297eb01000000304c806660a33745b4c0dddeffe356320000000002000000000003660000c000000010000000b54461d4b2c57b4c0696855bf52654150000000004800000a0000000100000003c6297cce29eeaeeaf0896cef40717dce800000056c0ad48ca1c635e33e06af674cbc479320c40f6eff53a9d8fee9d6c82cb1f12df026eb95d9238ed39493a398bf4d7e634a1ec9219164b65801194195b0875e4ab1246a9d0109831332ec55d8af6f62c2b142b854b29e6be5d55c504705766bb39b1550f5d96a81b7f809493aa560ce23902b1bf09f6d4e65a336e60f888280ecfa413d6bdafe400fd0029f025822980ee090ac896253165d92adc90e88ea752860e2530560c7c26c33247b13d0e41eba07a3e6c6591d3c4cac633621cd5d0405a01689170c72501f234029614d9a120c108e218f183e31af587be4bc14055024760a34245350c3114000000cb7cb0b1cd250d02acd86ee79617948b2924db8d"

# Convert to secure string
$TokenSecure = $TokenEncrypted | ConvertTo-SecureString

# Decrypt secure string
$TokenBSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($TokenSecure)
$Token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($TokenBSTR)

#endregion

#region Define XML filter
[XML]$FilterXML
#endregion

#region Process all getconnectors
Foreach ($GetConnector in $GetConnectors)
{
	$OutFileName = $GetConnector
	$OutFileName = $OutFileName.replace("iPublications_Employee","Cygnific_HRM_Employee")
	$OutFileName = $OutFileName.replace("iPublications_EmployeeAll","Cygnific_HRM_EmployeeAll")
	$OutFileName = $OutFileName.replace("iPublications_EmployeeBI","Cygnific_HRM_EmployeeBI")
	$OutFileName = $OutFileName.replace("iPublications_Organigram","Cygnific_HRM_Organigram")
    $OutFileName = $OutFileName.replace("iPublications_Course_Skill_Management_Languages","Cygnific_HRM_Course_Skill_Management_Languages")
	$OutFileName = $OutFileName.replace("iPublications_Organigram","Cygnific_HRM_Organigram")

	[XML]$Result = $ProfitServicesAppConnector.GetData($Token, $GetConnector, $FilterXML.OuterXml, -1, -1) | Out-File -filepath "$DestinationPath\$OutFilename.xml"
	Write-Host "Processing XML file for " $GetConnector
}
#endregion