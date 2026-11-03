resource "azurerm_servicebus_topic" "this" {
  for_each = var.topics

  name                = each.key
  namespace_id        = var.namespace_id
  default_message_ttl = "P14D"
}

resource "azurerm_servicebus_subscription" "api" {
  for_each = var.topics

  name               = "api-${each.key}"
  topic_id           = azurerm_servicebus_topic.this[each.key].id
  max_delivery_count = each.value.max_delivery_count
}
