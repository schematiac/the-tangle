variable "sql_server_name" {
  type = string
}

variable "sql_database_name" {
  type = string
}

variable "sql_sku_name" {
  type = string
}

variable "sql_admin_login" {
  type = string
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "storage_account_name" {
  type = string
}

variable "storage_replication_type" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "servicebus_namespace_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
