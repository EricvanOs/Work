// Add parameters

param location string = 'eastus'
param storageAccountName string = 'superunique45323' // must be globally unique

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
  }
}
