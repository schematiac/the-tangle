module "network" {
  source = "./modules/network"

  name                = local.vnet_name
  location            = var.location
  resource_group_name = local.rg_network_name
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = local.tags
}
