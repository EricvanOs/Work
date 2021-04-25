Class Employee {

    [ValidatePattern("^[a-z]+$")]
    [string]$FirstName
    [ValidatePattern("^[a-z]+$")]
    [string]$LastName
    hidden [string]$UserName
    [ValidateSet('Internal','External')]
    [string]
    $EmployeeType
    [ValidatePattern("^OU=")]
    [string]$OU
    hidden static [string]$DomainName = "DC=District,DC=Local"

[Employee]Create(){
        
        New-ADUser -SamAccountName $this.UserName `   # $this is a reference to the object’s current instance
                   -GivenName $this.FirstName `
                   -Surname $this.LastName `
                   -Name $this.UserName `
                   -UserPrincipalName $this.UserName `
                    -DisplayName ($this.FirstName + " " + $this.LastName) `
                    -Description ($this.FirstName + " " + $this.LastName) `
                    -Path $this.OU

        return $this
    }
# another method
[string]static GetNewUserName([string]$FirstName,[string]$LastName){

        $start = $LastName.replace(" ","").Substring(0,5)
        $end = $FirstName.Substring(0,2)
        
        
            $UName = ($start + $end).ToLower()
        
        
            $AllNames = Get-ADUser -Filter "SamaccountName -like '$UName*'"
            [int]$LastUsed = $AllNames | % {$_.SamAccountName.trim($Uname)} | select -Last 1
            $Next = $LastUsed+1
            $nextNumber = $Next.tostring().padleft(2,'0')
            $SamAccountName = $UName + $nextNumber
        return $SamAccountName
       }

}


[Employee]::GetNewUserName("Stephane","vanGulick")
