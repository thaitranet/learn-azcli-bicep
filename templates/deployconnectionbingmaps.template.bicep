param apiKey string

@description('Location where resources reside.')
param location string = resourceGroup().location

resource bingmaps 'Microsoft.Web/connections@2016-06-01' = {
  name: 'bingmaps'
  location: location
  kind: 'V1'
  properties: {
    displayName: 'BingMaps'
    parameterValues: {
      api_key: apiKey
    }
    statuses: [
      {
        status: 'Connected'
      }
    ]
    customParameterValues: {
    }
    nonSecretParameterValues: {
    }
    createdTime: '2022-07-07T04:47:47.6091265Z'
    changedTime: '2022-07-07T04:47:47.6091265Z'
    api: {
      name: 'bingmaps'
      displayName: 'Bing Maps'
      description: 'Bing Maps'
      iconUri: 'https://connectoricons-prod.azureedge.net/releases/v1.0.1567/1.0.1567.2748/bingmaps/icon.png'
      brandColor: '#008372'
      id: subscriptionResourceId('Microsoft.Web/locations/managedApis', location, 'bingmaps')
      type: 'Microsoft.Web/locations/managedApis'
    }
    testLinks: []
  }
}
