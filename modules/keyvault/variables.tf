variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "deployer_object_id" {
  description = "Object ID of the identity running Terraform. Gets Secrets Officer so it can write secrets."
  type        = string
}

variable "secrets" {
  description = "Secrets to create, keyed by secret name."
  type        = map(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
