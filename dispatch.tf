module "dispatch" {
  source = "./modules/app"

  plan_name           = local.plan_name
  portal_app_name     = local.portal_app_name
  api_app_name        = local.api_app_name
  location            = var.location
  resource_group_name = local.rg_app_name
  sku_name            = var.app_service_sku

  # VNet integration subnet for both web apps
  integration_subnet_id = module.network.subnet_ids["snet-data"]

  app_insights_connection_string = module.monitoring.app_insights_connection_string
  key_vault_uri                  = module.security.key_vault_uri
  servicebus_namespace_name      = module.persistence.servicebus_namespace_name
  carrier_edi_endpoint           = var.carrier_edi_endpoint
  tags                           = local.tags
}
