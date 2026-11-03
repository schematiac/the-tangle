environment = "dev"

vnet_address_space = ["10.40.0.0/16"]

subnets = {
  snet-app = {
    address_prefix = "10.40.1.0/24"
    delegation     = "Microsoft.Web/serverFarms"
  }
  snet-data = {
    address_prefix    = "10.40.2.0/24"
    service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
  }
  snet-integration = {
    address_prefix = "10.40.3.0/24"
    delegation     = "Microsoft.Web/serverFarms"
  }
}

app_service_sku          = "B1"
sql_sku_name             = "Basic"
storage_replication_type = "LRS"
enable_nat_gateway       = false
log_retention_days       = 30

carrier_edi_endpoint = "https://edi-sandbox.rattlesnakefreight.example/v2"

tags = {
  owner      = "platform"
  department = "Logistics"
}
