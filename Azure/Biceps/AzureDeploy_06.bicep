// Using the ternary operator
/*
You can conditionally provide a value for a variable, resource, or output using the ternary operator, 
which is the equivalent of the if() function in ARM Templates. 
Instead of using a variable for our storage sku, let's conditionally choose a redundancy setting for our storage account 
by adding a new parameter globalRedundancy and combining it with the ternary operator. As part of that, we can get rid of our storageSku variable.
*/

param location string = resourceGroup().location
param namePrefix string = 'stg'

param globalRedundancy bool = true // defaults to true, but can be overridden

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS' // if true --> GRS, else --> LRS
  }
}

output storageId string = stg.id
