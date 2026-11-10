module "monitoring" {
  source = "./modules/monitoring"

  workspace_name      = local.law_name
  app_insights_name   = local.appi_name
  location            = var.location
  resource_group_name = local.rg_app_name
  retention_in_days   = var.log_retention_days
  tags                = local.tags
}
