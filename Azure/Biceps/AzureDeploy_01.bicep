resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'superunique45323'  // must be globally unique
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
