# creating a class
Class Employee {
    [string]$FirstName
    [string]$LastName
    [string]$UserName
    [string]$EmployeeType
}

# under the hood the following takes place
Class Employee1 {
    [string]$FirstName
    [string]$LastName
    [string]$UserName
    [string]$EmployeeType

    Employee (){
    }
}

# add your own constructor
Class Employee2 {
    [string]$FirstName
    [string]$LastName
    [string]$UserName
    [string]$EmployeeType

    Employee ([String]$FirstName,[String]$Lastname,[String]$EmployeeType){

        #Initializing variables
         $UserOU = ""

         #Assigning property values
          $this.EmployeeType = $EmployeeType
          $this.FirstName = $FirstName
          $this.LastName = $Lastname

         #Notice the call to our static method [GetNewUserName]
          $this.UserName = [Employee2]::GetNewUserName($FirstName,$Lastname)

         #Notice the call to our static property [DomainName]
          $this.OU = "OU=$($EmployeeType)," + "OU=Users,OU=HQ," + [employee2]::DomainName           
      }

}

# example
$NewEmployee = [employee2]::new("Stephane","Van Gulick","Internal")
$NewEmployee