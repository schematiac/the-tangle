# DO NOT REMOVE. Carrier EDI allowlist. -D

locals {
  nat_pip_name = "pip-nat-${local.name_base}"
}

resource "azurerm_public_ip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  name                = local.nat_pip_name
  location            = "westus3"
  resource_group_name = local.rg_network_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_nat_gateway" "egress" {
  count = var.enable_nat_gateway ? 1 : 0

  name                    = "ng-${local.name_base}"
  location                = "westus3"
  resource_group_name     = local.rg_network_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags                    = local.tags
}

resource "azurerm_nat_gateway_public_ip_association" "egress" {
  count = var.enable_nat_gateway ? 1 : 0

  nat_gateway_id       = azurerm_nat_gateway.egress[0].id
  public_ip_address_id = azurerm_public_ip.nat[0].id
}

resource "azurerm_subnet_nat_gateway_association" "integration" {
  count = var.enable_nat_gateway ? 1 : 0

  subnet_id      = module.network.subnet_ids["snet-integration"]
  nat_gateway_id = azurerm_nat_gateway.egress[0].id
}
