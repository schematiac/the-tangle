module "network" {
  source = "./modules/network"

  name                = local.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = local.tags
}
