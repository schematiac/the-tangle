output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Subnet IDs keyed by subnet name."
  value       = { for k, s in azurerm_subnet.this : k => s.id }
}
