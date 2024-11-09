resource_group_name           = "acr-test-rg"
location                      = "southeastasia"
sku                           = "Standard"
admin_enabled                 = false
public_network_access_enabled = true
quarantine_policy_enabled     = false
retention_policy_in_days      = null
trust_policy_enabled          = false
zone_redundancy_enabled       = false
export_policy_enabled         = true
anonymous_pull_enabled        = false
data_endpoint_enabled         = false
network_rule_bypass_option    = "AzureServices"

georeplications_location                  = null
georeplications_regional_endpoint_enabled = null
georeplications_zone_redundancy_enabled   = null
georeplications_tags                      = null
network_rule_set_default_action           = null
network_rule_set_ip_rule_action           = null
network_rule_set_ip_rule_ip_range         = null
identity_type                             = "SystemAssigned"
identity_identity_ids                     = null

encryption_identity_client_id = null
encryption_key_vault_key_id   = null



