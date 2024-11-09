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

variable "georeplications" {
  description = "A list of georeplications block as defined below."
  type = list(object({
    location                  = string
    regional_endpoint_enabled = bool
    zone_redundancy_enabled   = bool
    tags                      = map(string)
  }))
  default = []
}

variable "network_rule_set" {
  description = "A network_rule_set block as defined below."
  type = object({
    default_action = string
    ip_rule = object({
      action   = string
      ip_range = string
    })
  })
  default = null
}

variable "identity" {
  description = "An identity block as defined below."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = null
}

variable "encryption" {
  description = "An encryption block as defined below."
  type = object({
    key_vault_key_id   = string
    identity_client_id = string
  })
  default = null
}

variable "naming_convention_info" {
  description = "A naming_convention_info block as defined below."
  type = object({
    name = string
    env  = string
    zone = string
    tier = string
  })

}