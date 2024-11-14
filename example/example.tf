locals {
  naming_convention_info = {
    env  = "env"
    site = "zn"
    app = "www"
    name = "001"
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
  source                        = "git::https://github.com/BrettOJ/tf-az-module-azure-container-registry?ref=main"
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
  naming_convention_info        = local.naming_convention_info
  georeplications               = null
  network_rule_set = null

  identity = {
    type         = var.identity_type
    identity_ids = var.identity_identity_ids
  }

  encryption = null
}

