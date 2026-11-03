variable "plan_name" {
  type = string
}

variable "portal_app_name" {
  type = string
}

variable "api_app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "integration_subnet_id" {
  description = "Subnet used for regional VNet integration. Must be delegated to Microsoft.Web/serverFarms."
  type        = string
}

variable "app_insights_connection_string" {
  type      = string
  sensitive = true
}

variable "key_vault_uri" {
  type = string
}

variable "servicebus_namespace_name" {
  type = string
}

variable "carrier_edi_endpoint" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
