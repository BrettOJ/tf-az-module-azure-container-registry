variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium."
  type        = string
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled."
  type        = bool
  default     = false
}


variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the container registry."
  type        = bool
  default     = true
}

variable "quarantine_policy_enabled" {
  description = "Boolean value that indicates whether quarantine policy is enabled."
  type        = bool
  default     = false
}

variable "retention_policy_in_days" {
  description = "The number of days to retain and untagged manifest after which it gets purged."
  type        = number
  default     = 7
}

variable "trust_policy_enabled" {
  description = "Boolean value that indicated whether trust policy is enabled."
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Whether zone redundancy is enabled for this Container Registry?"
  type        = bool
  default     = false
}

variable "export_policy_enabled" {
  description = "Boolean value that indicates whether export policy is enabled."
  type        = bool
  default     = true
}

variable "anonymous_pull_enabled" {
  description = "Whether allows anonymous (unauthenticated) pull access to this Container Registry?"
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry?"
  type        = bool
  default     = false
}

variable "network_rule_bypass_option" {
  description = "Whether to allow trusted Azure services to access a network restricted Container Registry?"
  type        = string
  default     = "AzureServices"
}

variable "georeplications_location" {
  description = "The location of the georeplication. Possible values are East US, West US, North Central US, South Central US, Central US, East US 2, West US 2, Japan East, Japan West, Brazil South, Australia East, Australia Southeast, Central India, South India, West India, Canada Central, Canada East, UK South, UK West, West Central US, West US 3, South Africa North, South Africa West, UAE North, UAE Central, Korea Central, Korea South, France Central, France South, Germany West Central, Norway East, Norway West, Switzerland North, Switzerland West, North Europe, West Europe, East Asia, Southeast Asia, East US 2, North Central US, South Central US, Central US, West US 2, West Central US, East US, West US, Australia East, Australia Southeast, Central India, South India, West India, Canada Central, Canada East, UK South, UK West, West Central US, West US 3, South Africa North, South Africa West, UAE North, UAE Central, Korea Central, Korea South, France Central, France South, Germany West Central, Norway East, Norway West, Switzerland North, Switzerland West, North Europe, West Europe, East Asia, Southeast Asia."
  type        = string
}

variable "georeplications_regional_endpoint_enabled" {
  description = "Specifies whether the regional endpoint is enabled."
  type        = bool
}

variable "georeplications_zone_redundancy_enabled" {
  description = "Specifies whether the zone redundancy is enabled."
  type        = bool
}

variable "georeplications_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "network_rule_set_default_action" {
  description = "The default action of allow or deny when no other rules match."
  type        = string
}

variable "network_rule_set_ip_rule_action" {
  description = "The action of the rule. Possible values are Allow and Deny."
  type        = string
}

variable "network_rule_set_ip_rule_ip_range" {
  description = "The IP range in CIDR format."
  type        = string
}

variable "identity_type" {
  description = "The type of identity used for the container registry. Possible values are SystemAssigned and None."
  type        = string
}

variable "identity_identity_ids" {
  description = "A list of identities associated with the container registry."
  type        = list(string)
}

variable "encryption_key_vault_key_id" {
  description = "The key vault key id."
  type        = string
}

variable "encryption_identity_client_id" {
  description = "The client id of the identity used for encryption."
  type        = string
}

