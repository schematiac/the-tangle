output "sql_server_id" {
  value = azurerm_mssql_server.this.id
}

output "sql_server_fqdn" {
  value = "${local.sql_server_name}.database.windows.net"
}

output "sql_connection_string" {
  sensitive = true
  value     = "Server=tcp:${azurerm_mssql_server.this.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.shipments.name};User ID=${var.sql_admin_login};Password=${var.sql_admin_password};Encrypt=True;"
}

output "storage_account_id" {
  value = azurerm_storage_account.docs.id
}

output "storage_account_name" {
  value = local.storage_account_name
}

output "servicebus_namespace_id" {
  value = azurerm_servicebus_namespace.tracking.id
}

output "servicebus_namespace_name" {
  value = local.servicebus_namespace_name
}

output "servicebus_primary_connection_string" {
  sensitive = true
  value     = azurerm_servicebus_namespace.tracking.default_primary_connection_string
}
