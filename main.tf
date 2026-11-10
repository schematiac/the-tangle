resource "azurerm_resource_group" "network" {
  name     = local.rg_network_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_resource_group" "app" {
  name     = local.rg_app_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_resource_group" "data" {
  name     = local.rg_data_name
  location = "westus3"
  tags     = local.tags
}
