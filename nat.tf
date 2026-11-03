# DO NOT REMOVE. Carrier EDI allowlist. -D

resource "azurerm_public_ip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  name                = "pip-nat-${local.name_base}"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_nat_gateway" "egress" {
  count = var.enable_nat_gateway ? 1 : 0

  name                    = "ng-${local.name_base}"
  location                = var.location
  resource_group_name     = azurerm_resource_group.network.name
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
