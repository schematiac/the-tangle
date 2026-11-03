resource "azurerm_service_plan" "this" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "portal" {
  name                      = var.portal_app_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id           = azurerm_service_plan.this.id
  https_only                = true
  virtual_network_subnet_id = var.integration_subnet_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on              = true
    ftps_state             = "Disabled"
    vnet_route_all_enabled = true

    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.app_insights_connection_string
    KEY_VAULT_URI                         = var.key_vault_uri
    API_BASE_URL                          = "https://${azurerm_linux_web_app.api.default_hostname}"
    ASPNETCORE_ENVIRONMENT                = "Production"
  }

  tags = var.tags
}

resource "azurerm_linux_web_app" "api" {
  name                      = var.api_app_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id           = azurerm_service_plan.this.id
  https_only                = true
  virtual_network_subnet_id = var.integration_subnet_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on              = true
    ftps_state             = "Disabled"
    vnet_route_all_enabled = true

    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.app_insights_connection_string
    KEY_VAULT_URI                         = var.key_vault_uri
    SERVICEBUS_NAMESPACE                  = "${var.servicebus_namespace_name}.servicebus.windows.net"
    CARRIER_EDI_ENDPOINT                  = var.carrier_edi_endpoint
    ASPNETCORE_ENVIRONMENT                = "Production"
  }

  tags = var.tags
}
