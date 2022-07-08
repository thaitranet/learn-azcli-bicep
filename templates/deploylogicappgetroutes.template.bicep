param workflowsName string = 'melbourneairportdevlogicappgetroutes1'
param azureTablesConnectionId string = resourceId('Microsoft.Web/connections', 'azuretables')
param azureTablesId string = subscriptionResourceId('Microsoft.Web/locations/managedApis', resourceGroup().location, 'azuretables')
param bingMapsConnectionId string = resourceId('Microsoft.Web/connections', 'bingmaps')
param bingMapsId string = subscriptionResourceId('Microsoft.Web/locations/managedApis', resourceGroup().location, 'bingmaps')

resource workflowsName_resource 'Microsoft.Logic/workflows@2017-07-01' = {
  name: workflowsName
  location: location
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        '$connections': {
          defaultValue: {
          }
          type: 'Object'
        }
      }
      triggers: {
        Recurrence: {
          recurrence: {
            frequency: 'Minute'
            interval: 5
          }
          evaluatedRecurrence: {
            frequency: 'Minute'
            interval: 5
          }
          type: 'Recurrence'
        }
      }
      actions: {
        Compose: {
          runAfter: {
            Get_route: [
              'Succeeded'
            ]
          }
          type: 'Compose'
          inputs: {
            Body: '@string(body(\'Get_route\'))'
          }
        }
        Get_route: {
          runAfter: {
          }
          type: 'ApiConnection'
          inputs: {
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'bingmaps\'][\'connectionId\']'
              }
            }
            method: 'get'
            path: '/V3/REST/V1/Routes/@{encodeURIComponent(\'Driving\')}'
            queries: {
              avoid_borderCrossing: false
              avoid_ferry: false
              avoid_highways: false
              avoid_minimizeHighways: false
              avoid_minimizeTolls: false
              avoid_tolls: false
              'wp.0': 'Melbourne VIC 3000'
              'wp.1': 'Melbourne Airport VIC 3045'
            }
          }
        }
        'Insert_or_Merge_Entity_(V2)': {
          runAfter: {
            Compose: [
              'Succeeded'
            ]
          }
          type: 'ApiConnection'
          inputs: {
            body: '@outputs(\'Compose\')'
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'azuretables\'][\'connectionId\']'
              }
            }
            method: 'patch'
            path: '/v2/storageAccounts/@{encodeURIComponent(encodeURIComponent(\'AccountNameFromSettings\'))}/tables/@{encodeURIComponent(\'bingmaps\')}/entities(PartitionKey=\'@{encodeURIComponent(\'1\')}\',RowKey=\'@{encodeURIComponent(\'1\')}\')'
          }
        }
      }
      outputs: {
      }
    }
    parameters: {
      '$connections': {
        value: {
          azuretables: {
            connectionId: azureTablesConnectionId
            connectionName: 'azuretables'
            id: azureTablesId
          }
          bingmaps: {
            connectionId: bingMapsConnectionId
            connectionName: 'bingmaps'
            id: bingMapsId
          }
        }
      }
    }
  }
}
