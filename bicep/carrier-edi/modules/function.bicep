param planName string
param functionAppName string
param location string
param integrationSubnetId string
param storageAccountName string

@secure()
param appInsightsConnectionString string

param carrierEdiEndpoint string
param tags object = {}

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

resource plan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: planName
  location: location
  kind: 'elastic'
  sku: {
    name: 'EP1'
    tier: 'ElasticPremium'
  }
  properties: {
    reserved: true
    maximumElasticWorkerCount: 3
  }
  tags: tags
}

resource func 'Microsoft.Web/sites@2023-12-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    virtualNetworkSubnetId: integrationSubnetId
    // all outbound through the VNet so the carrier sees one fixed IP
    vnetRouteAllEnabled: true
    siteConfig: {
      linuxFxVersion: 'DOTNET-ISOLATED|8.0'
      ftpsState: 'Disabled'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storage.name};AccountKey=${storage.listKeys().keys[0].value};EndpointSuffix=${environment().suffixes.storage}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet-isolated'
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsightsConnectionString
        }
        {
          name: 'CARRIER_EDI_ENDPOINT'
          value: carrierEdiEndpoint
        }
      ]
    }
  }
  tags: tags
}

output name string = func.name
output defaultHostname string = func.properties.defaultHostName
output principalId string = func.identity.principalId
