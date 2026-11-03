variable "namespace_id" {
  type = string
}

variable "topics" {
  type = map(object({
    max_delivery_count = optional(number, 10)
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
