param workflowsName string = 'melbourneairportdevlogicapsendroutes1'
param azureTablesConnectionId string = resourceId('Microsoft.Web/connections', 'azuretables')
param azureTablesId string = subscriptionResourceId('Microsoft.Web/locations/managedApis', resourceGroup().location, 'azuretables')

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
        manual: {
          type: 'Request'
          kind: 'Http'
          inputs: {
            method: 'GET'
          }
        }
      }
      actions: {
        'Get_entities_(V2)': {
          runAfter: {
          }
          type: 'ApiConnection'
          inputs: {
            host: {
              connection: {
                name: '@parameters(\'$connections\')[\'azuretables\'][\'connectionId\']'
              }
            }
            method: 'get'
            path: '/v2/storageAccounts/@{encodeURIComponent(encodeURIComponent(\'AccountNameFromSettings\'))}/tables/@{encodeURIComponent(\'bingmaps\')}/entities'
          }
        }
        Response: {
          runAfter: {
            'Get_entities_(V2)': [
              'Succeeded'
            ]
          }
          type: 'Response'
          kind: 'Http'
          inputs: {
            body: '@body(\'Get_entities_(V2)\')?[\'value\'][0].Body'
            statusCode: 200
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
        }
      }
    }
  }
}
