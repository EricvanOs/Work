// Using string interpolation
/*
The concat() function is one of the most commonly used ARM Template functions and can add a lot of verbosity to a template. To simplify this, we now support a string interpolation syntax.

For example, I could combine a namePrefix parameter with a hardcoded suffix:

param namePrefix string = 'unique'

var storageAccountName = '${namePrefix}storage001'
Which is equivalent to the following ARM Template concat() function:

{
  "variables": {
    "storageAccountName": "[concat(parameters('namePrefix'), 'storage001')]"
  }
}
*/

// Let's use a namePrefix parameter and concatenate that with our uniqueString() using string interpolation.

param location string = resourceGroup().location
param namePrefix string = 'stg'

var storageSku = 'Standard_LRS' // declare variable and assign value
var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: storageSku
  }
}

output storageId string = stg.id
