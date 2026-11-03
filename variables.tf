variable "environment" {
  description = "Deployment environment (dev, staging, prod)."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "westus3"
}

variable "location_short" {
  description = "Short region code used in resource names."
  type        = string
  default     = "wus3"
}

variable "instance" {
  description = "Instance number used in resource names."
  type        = number
  default     = 1
}

variable "vnet_address_space" {
  description = "Address space for the dispatch VNet."
  type        = list(string)
  default     = ["10.40.0.0/16"]
}

variable "subnets" {
  description = "Subnets to create. The key is the subnet name."
  type = map(object({
    address_prefix    = string
    service_endpoints = optional(list(string), [])
    delegation        = optional(string)
  }))
}

variable "app_service_sku" {
  description = "App Service plan SKU for the portal and API."
  type        = string
  default     = "B1"
}

variable "sql_sku_name" {
  description = "SKU for the shipments database."
  type        = string
  default     = "S0"
}

variable "sql_admin_login" {
  description = "SQL administrator login name."
  type        = string
  default     = "twladmin"
}

variable "storage_replication_type" {
  description = "Replication type for the shipment documents storage account."
  type        = string
  default     = "LRS"
}

variable "enable_nat_gateway" {
  description = "Attach a NAT gateway to the integration subnet for a fixed egress IP."
  type        = bool
  default     = false
}

variable "carrier_edi_endpoint" {
  description = "Base URL of the carrier EDI API."
  type        = string
}

variable "log_retention_days" {
  description = "Log Analytics retention in days."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to every resource, merged with the standard set."
  type        = map(string)
  default     = {}
}
