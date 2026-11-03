environment = "prod"

vnet_address_space = ["10.50.0.0/16"]

subnets = {
  snet-app = {
    address_prefix = "10.50.1.0/24"
    delegation     = "Microsoft.Web/serverFarms"
  }
  snet-data = {
    address_prefix    = "10.50.2.0/24"
    service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
  }
  snet-integration = {
    address_prefix = "10.50.3.0/24"
    delegation     = "Microsoft.Web/serverFarms"
  }
  snet-mgmt = {
    address_prefix = "10.50.250.0/27"
  }
}

app_service_sku          = "P1v3"
sql_sku_name             = "Basic"
storage_replication_type = "GRS"
enable_nat_gateway       = true
log_retention_days       = 90

carrier_edi_endpoint = "https://edi.rattlesnakefreight.example/v2"

tags = {
  owner      = "platform"
  department = "Logisitcs"
}
