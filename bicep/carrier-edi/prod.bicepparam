using './main.bicep'

param env = 'prod'
param integrationSubnetId = '/subscriptions/4f1c2a9e-7d3b-4e58-9a6f-2c8e1b0d5a73/resourceGroups/rg-twl-dispatch-prd-wus3-01-net/providers/Microsoft.Network/virtualNetworks/vnet-twl-dispatch-prd-wus3-01/subnets/snet-integration'
param appInsightsConnectionString = readEnvironmentVariable('APPINSIGHTS_CONNECTION_STRING', '')
param carrierEdiEndpoint = 'https://edi.rattlesnakefreight.example/v2'
param tags = {
  environment: 'prod'
  workload: 'edi'
  managed_by: 'bicep'
  owner: 'platform'
}
