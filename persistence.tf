module "persistence" {
  source = "./modules/data"

  sql_server_name    = local.sql_server_name
  sql_database_name  = local.sql_db_name
  sql_sku_name       = var.sql_sku_name
  sql_admin_login    = var.sql_admin_login
  sql_admin_password = random_password.sql_admin.result

  storage_account_name       = local.storage_name
  storage_replication_type   = var.storage_replication_type
  private_endpoint_subnet_id = module.network.subnet_ids["snet-data"]

  servicebus_namespace_name = local.sb_name # TODO: move to tracking

  location            = var.location
  resource_group_name = local.rg_data_name
  tags                = local.tags
}
