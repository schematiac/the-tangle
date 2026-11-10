// Carrier EDI relay + label printing.
// Still Bicep. Port to Terraform once the NAT thing is sorted. -D
targetScope = 'resourceGroup'

@description('Deployment environment.')
@allowed(['dev', 'prod'])
param env string

param location string = resourceGroup().location

@description('Resource ID of snet-integration in the dispatch VNet. Terraform owns the VNet.')
param integrationSubnetId string

@description('Application Insights connection string from the dispatch monitoring stack.')
@secure()
param appInsightsConnectionString string

@description('Base URL of the carrier EDI API.')
param carrierEdiEndpoint string

param tags object = {}

var envShort = env == 'prod' ? 'prd' : 'dev'
var nameBase = 'twl-edi-${envShort}-wus3-01'
var storageName = toLower(replace('sttwledi${envShort}wus301', '-', ''))

module storage 'modules/storage.bicep' = {
  name: 'edi-storage'
  params: {
    name: storageName
    location: location
    tags: tags
  }
}

module func 'modules/function.bicep' = {
  name: 'edi-function'
  params: {
    planName: 'asp-${nameBase}'
    functionAppName: 'func-${nameBase}'
    location: location
    integrationSubnetId: integrationSubnetId
    storageAccountName: storageName
    appInsightsConnectionString: appInsightsConnectionString
    carrierEdiEndpoint: carrierEdiEndpoint
    tags: tags
  }
}

output functionAppName string = func.outputs.name
output functionAppHostname string = func.outputs.defaultHostname
