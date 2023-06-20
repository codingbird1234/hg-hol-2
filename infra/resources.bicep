// add parameters for name and location that defaults to the resourcegroup's location
// add a parameter for the appServicePlanName that defaults to the name parameter
// add a parameter for the appServicePlanSku that defaults to 'B1'


param name string
param location string = resourceGroup().location

resource asplan 'Microsoft.Web/serverfarms@2021-02-01' = {
  // add name with the prefix of 'asplan-'
  name: '$asplan-${name}'
  location: location
  kind: 'app'
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource appsvc 'Microsoft.Web/sites@2021-02-01' = {
// add name with the prefix of 'appsvc-'
// add location with the parameter location
// add dependsOn with the value of appServicePlan
// add properties.serverFarmId with the value of appServicePlan.id
  name: 'appsvc-${name}'
  location: location
  kind: 'app'
  properties: {
    serverFarmId: asplan.id
  }
}
