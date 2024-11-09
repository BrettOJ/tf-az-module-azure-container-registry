resource "azurerm_container_registry" "acr" {
  name                          = module.acr_name.naming_convention_output["${var.naming_convention_info.name}"].names.0
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled
  retention_policy_in_days      = var.retention_policy_in_days
  trust_policy_enabled          = var.trust_policy_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  export_policy_enabled         = var.export_policy_enabled
  anonymous_pull_enabled        = var.anonymous_pull_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option
  tags                          = var.tags

  dynamic "georeplications" {
    for_each = var.georeplications != null ? var.georeplications : []
    content {
      location                  = var.georeplications.location
      regional_endpoint_enabled = var.georeplications.regional_endpoint_enabled
      zone_redundancy_enabled   = var.georeplications.zone_redundancy_enabled
      tags                      = var.georeplications.tags
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rule_set != null ? var.network_rule_set : []
    content {
      default_action = var.network_rule_set.default_action
      ip_rule {
        action   = var.network_rule_set.ip_rule.action
        ip_range = var.network_rule_set.ip_rule.ip_range
      }
    }
  }

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  encryption {
    key_vault_key_id   = var.encryption.key_vault_key_id
    identity_client_id = var.encryption.identity_client_id
  }

}

