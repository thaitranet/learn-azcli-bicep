@description('Name of the Azure Storage account.')
param storageAccountName string

@description('Location where resources reside.')
param location string = resourceGroup().location

var storageAccountId = resourceId('Microsoft.Storage/storageAccounts', storageAccountName)

resource azuretables 'Microsoft.Web/connections@2016-06-01' = {
  name: 'azuretables'
  location: location
  kind: 'V1'
  properties: {
    displayName: 'storageaccount'
    parameterValues: {
      storageAccount: storageAccountName
      sharedKey: listKeys(storageAccountId, '2019-04-01').keys[0].value
    }
    statuses: [
      {
        status: 'Connected'
      }
    ]
    customParameterValues: {
    }
    createdTime: '2022-07-07T05:53:40.1444071Z'
    changedTime: '2022-07-07T05:53:40.1444071Z'
    api: {
      name: 'azuretables'
      displayName: 'Azure Table Storage'
      description: 'Azure Table storage is a service that stores structured NoSQL data in the cloud, providing a key/attribute store with a schemaless design. Sign into your Storage account to create, update, and query tables and more.'
      iconUri: 'https://connectoricons-prod.azureedge.net/releases/v1.0.1582/1.0.1582.2855/azuretables/icon.png'
      brandColor: '#804998'
      id: subscriptionResourceId('Microsoft.Web/locations/managedApis', location, 'azuretables')
      type: 'Microsoft.Web/locations/managedApis'
    }
    testLinks: [
      {
        requestUri: 'https://management.azure.com:443${resourceGroup().id}/providers/Microsoft.Web/connections/azuretables/extensions/proxy/testConnection?api-version=2016-06-01'
        method: 'get'
      }
    ]
  }
}
