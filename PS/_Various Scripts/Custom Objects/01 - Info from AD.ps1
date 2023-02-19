Import-Module ActiveDirectory

$aResults = @()
$List = 'Jim','Leo'
            
ForEach ($Item in $List) {
  $Item = $Item.Trim()
  $User = Get-ADUser -Filter { GivenName -like $Item  -and Enabled -eq $True } -Properties SamAccountName, GivenName, Surname, telephoneNumber
  $sEmail = $User.GivenName + "." + "@test.com"

  $hItemDetails = [PSCustomObject]@{ 
    FullName = $Item
    UserName = $User.SamAccountName
    Email = $sEmail
    Tel = $User.telephoneNumber
  }

  #Add data to array
  $aResults += $hItemDetails
}

$aResults 