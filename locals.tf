locals {
  org      = "twl"
  workload = "dispatch"

  # prod -> prd, staging -> stg, anything else -> dev
  env_short = substr(var.environment, 0, 1) == "p" ? "prd" : (substr(var.environment, 0, 1) == "s" ? "stg" : "dev")

  instance_padded = format("%02d", var.instance)

  name_base = "${local.org}-${local.workload}-${local.env_short}-${var.location_short}-${local.instance_padded}"

  rg_network_name = "rg-${local.name_base}-net"
  rg_app_name     = "rg-${local.name_base}-app"
  rg_data_name    = "rg-${local.name_base}-data"

  vnet_name       = "vnet-${local.name_base}"
  plan_name       = "asp-${local.name_base}"
  portal_app_name = "app-${local.org}-portal-${local.env_short}-${var.location_short}-${local.instance_padded}"
  api_app_name    = "app-${local.org}-api-${local.env_short}-${var.location_short}-${local.instance_padded}"
  sql_server_name = "sql-${local.name_base}"
  sql_db_name     = "sqldb-${local.org}-shipments-${local.env_short}"
  sb_name         = "sb-${local.name_base}"
  law_name        = "log-${local.name_base}"
  appi_name       = "appi-${local.name_base}"

  # key vault: 3-24 chars
  kv_name = substr("kv-${local.org}${local.workload}${local.env_short}${local.instance_padded}", 0, 24)

  # storage: 3-24 chars, lowercase letters and numbers only
  storage_name = lower(replace(substr("st${local.org}${local.workload}docs${local.env_short}${var.location_short}${local.instance_padded}", 0, 24), "-", ""))

  tags = merge(var.tags, {
    environment = var.environment
    workload    = local.workload
    managed_by  = "terraform"
    cost_center = "CC-${upper(local.workload)}-${upper(local.env_short)}"
  })
}
