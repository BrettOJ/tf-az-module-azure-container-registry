locals {
  naming_convention_info = {
    env          = "env"
    zone         = "zn"
    tier         = "www"
    name         = "001"
  }
  tags = {
    environment = "prd"
  }
}

data "azurerm_client_config" "current" {}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags                   = local.tags
    }
  }
}

module "azurerm_container_registry" {
source = "git::https://github.com/BrettOJ/tf-az-module-azure-container-registry?ref=main"
  resource_group_name           = module.resource_groups.rg_output[1].name
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
  tags                          = local.tags
  namung_convention_info        = local.naming_convention_info

    georeplications = {
        location                  = var.georeplications_location
        regional_endpoint_enabled = var.georeplications_regional_endpoint_enabled
        zone_redundancy_enabled   = var.georeplications_zone_redundancy_enabled
        tags                      = var.georeplications_tags
        }
  

  network_rule_set = {
      default_action = var.network_rule_set_default_action
      ip_rule = {
        action   = var.network_rule_set_ip_rule_action
        ip_range = var.network_rule_set_ip_rule_ip_range
      }
    }
  

  identity = {
    type         = var.identity_type
    identity_ids = var.identity_identity_ids
  }

  encryption = {
    key_vault_key_id   = var.encryption_key_vault_key_id
    identity_client_id = var.encryption_identity_client_id
  }
}

resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "registry-uai"
}

data "azurerm_key_vault_key" "example" {
  name         = "super-secret"
  key_vault_id = data.azurerm_key_vault.existing.id
}