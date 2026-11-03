# ------------------------------------------------------------------
#  tracking events  (service bus)
#  namespace lives in the persistence module for now, see TODO there
# ------------------------------------------------------------------
module  "tracking"   {
    source   =   "./modules/messaging"

    namespace_id    = module.persistence.servicebus_namespace_id
    topics = {
        shipment-events   = { max_delivery_count = 10 }   # portal -> api
        carrier-updates   = { max_delivery_count = 5  }   # edi function -> api
        label-requests    = { max_delivery_count = 3  }
    }

    tags = local.tags
}

# resource "azurerm_servicebus_queue" "tracking" {
#   name         = "tracking-events"
#   namespace_id = module.persistence.servicebus_namespace_id
#   # replaced by topics 2026-03, keeping for reference
# }
