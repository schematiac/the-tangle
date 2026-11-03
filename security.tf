module "security" {
  source = "./modules/keyvault"

  name                = local.kv_name
  location            = var.location
  resource_group_name = azurerm_resource_group.app.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  deployer_object_id  = data.azurerm_client_config.current.object_id

  secrets = {
    sql-admin-password    = random_password.sql_admin.result
    sql-connection-string = module.persistence.sql_connection_string
    servicebus-connection = module.persistence.servicebus_primary_connection_string
  }

  tags = local.tags
}

resource "azurerm_role_assignment" "portal_secrets" {
  scope                = module.security.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.dispatch.portal_principal_id
}

resource "azurerm_role_assignment" "api_secrets" {
  scope                = module.security.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.dispatch.api_principal_id
}
