output "topic_ids" {
  value = { for k, t in azurerm_servicebus_topic.this : k => t.id }
}
