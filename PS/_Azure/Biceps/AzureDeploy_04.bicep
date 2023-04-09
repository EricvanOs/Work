// Using a Bicep function
// Any valid ARM Template function is also a valid Bicep function.

/* The following are all valid function calls in Bicep:

param currentTime string = utcNow()

var location = resourceGroup().location

output makeCapital string = toUpper('all lowercase')
*/

// use some functions
param location string = resourceGroup().location

var storageSku = 'Standard_LRS' // declare variable and assign value

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: uniqueString(resourceGroup().id) // generates unique name based on resource group ID
  location: location
  kind: 'Storage'
  sku: {
    name: storageSku // assign variable
  }
}

output storageId string = stg.id
