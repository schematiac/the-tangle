output "portal_url" {
  value = "https://${module.dispatch.portal_default_hostname}"
}

output "api_url" {
  value = "https://${module.dispatch.api_default_hostname}"
}

output "sql_server_fqdn" {
  value = module.persistence.sql_server_fqdn
}

output "storage_account_name" {
  value = module.persistence.storage_account_name
}

output "nat_egress_ip" {
  description = "Give this to the carrier for their allowlist."
  value       = var.enable_nat_gateway ? azurerm_public_ip.nat[0].ip_address : null
}
