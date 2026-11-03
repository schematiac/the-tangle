output "plan_id" {
  value = azurerm_service_plan.this.id
}

output "portal_default_hostname" {
  value = azurerm_linux_web_app.portal.default_hostname
}

output "api_default_hostname" {
  value = azurerm_linux_web_app.api.default_hostname
}

output "portal_principal_id" {
  value = azurerm_linux_web_app.portal.identity[0].principal_id
}

output "api_principal_id" {
  value = azurerm_linux_web_app.api.identity[0].principal_id
}
