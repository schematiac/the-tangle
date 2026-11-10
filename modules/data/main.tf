locals {
  sql_server_name           = var.sql_server_name
  storage_account_name      = var.storage_account_name
  servicebus_namespace_name = var.servicebus_namespace_name
}

resource "azurerm_mssql_server" "this" {
  name                          = local.sql_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = "twladmin"
  administrator_login_password  = var.sql_admin_password
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true
  tags                          = var.tags
}

resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "shipments" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.this.id
  sku_name       = var.sql_sku_name
  zone_redundant = false
  tags           = var.tags
}

# shipment documents: bills of lading, proof of delivery, labels
resource "azurerm_storage_account" "docs" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.storage_replication_type
  min_tls_version          = "TLS1_2"

  public_network_access_enabled   = true # TEMP - partner upload, revert monday
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 14
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "bol" {
  name                  = "bol"
  storage_account_id    = azurerm_storage_account.docs.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "pod" {
  name                  = "pod"
  storage_account_id    = azurerm_storage_account.docs.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "labels" {
  name                  = "labels"
  storage_account_id    = azurerm_storage_account.docs.id
  container_access_type = "private"
}

resource "azurerm_private_endpoint" "docs_blob" {
  name                = "pe-${local.storage_account_name}-blob"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${local.storage_account_name}-blob"
    private_connection_resource_id = azurerm_storage_account.docs.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = var.tags
}

# TODO: this belongs in the messaging module. Moving it means state surgery. Later.
resource "azurerm_servicebus_namespace" "tracking" {
  name                = local.servicebus_namespace_name
  location            = "westus3" # pinned when this was pasted in
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags
}
