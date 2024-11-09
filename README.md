# tf-az-module-azure-container-registry
Terraform module to create an azure container registry

Manages an Azure Container Registry.

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage)

```hcl
resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_container_registry" "acr" { name = "containerRegistry1" resource_group_name = azurerm_resource_group.example.name location = azurerm_resource_group.example.location sku = "Premium" admin_enabled = false georeplications { location = "East US" zone_redundancy_enabled = true tags = {} } georeplications { location = "North Europe" zone_redundancy_enabled = true tags = {} } }
```

## [Example Usage (Encryption)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage-encryption)

```hcl
resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_container_registry" "acr" { name = "containerRegistry1" resource_group_name = azurerm_resource_group.example.name location = azurerm_resource_group.example.location sku = "Premium" identity { type = "UserAssigned" identity_ids = [ azurerm_user_assigned_identity.example.id ] } encryption { key_vault_key_id = data.azurerm_key_vault_key.example.id identity_client_id = azurerm_user_assigned_identity.example.client_id } } resource "azurerm_user_assigned_identity" "example" { resource_group_name = azurerm_resource_group.example.name location = azurerm_resource_group.example.location name = "registry-uai" } data "azurerm_key_vault_key" "example" { name = "super-secret" key_vault_id = data.azurerm_key_vault.existing.id }
```

## [Example Usage (Attaching a Container Registry to a Kubernetes Cluster)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage-attaching-a-container-registry-to-a-kubernetes-cluster)

```hcl
resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_container_registry" "example" { name = "containerRegistry1" resource_group_name = azurerm_resource_group.example.name location = azurerm_resource_group.example.location sku = "Premium" } resource "azurerm_kubernetes_cluster" "example" { name = "example-aks1" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name dns_prefix = "exampleaks1" default_node_pool { name = "default" node_count = 1 vm_size = "Standard_D2_v2" } identity { type = "SystemAssigned" } tags = { Environment = "Production" } } resource "azurerm_role_assignment" "example" { principal_id = azurerm_kubernetes_cluster.example.kubelet_identity[0].object_id role_definition_name = "AcrPull" scope = azurerm_container_registry.example.id skip_service_principal_aad_check = true }
```

## [Argument Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#argument-reference)

The following arguments are supported:

-   [`name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#name-1) - (Required) Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created.
    
-   [`resource_group_name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#resource_group_name-1) - (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created.
    
-   [`location`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#location-1) - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
    
-   [`sku`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#sku-1) - (Required) The SKU name of the container registry. Possible values are `Basic`, `Standard` and `Premium`.
    
-   [`admin_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#admin_enabled-1) - (Optional) Specifies whether the admin user is enabled. Defaults to `false`.
    
-   [`tags`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#tags-1) - (Optional) A mapping of tags to assign to the resource.
    
-   [`georeplications`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#georeplications-1) - (Optional) One or more `georeplications` blocks as documented below.
    

-   [`network_rule_set`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#network_rule_set-1) - (Optional) A `network_rule_set` block as documented below.
    
-   [`public_network_access_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#public_network_access_enabled-1) - (Optional) Whether public network access is allowed for the container registry. Defaults to `true`.
    
-   [`quarantine_policy_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#quarantine_policy_enabled-1) - (Optional) Boolean value that indicates whether quarantine policy is enabled.
    
-   [`retention_policy_in_days`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#retention_policy_in_days-1) - (Optional) The number of days to retain and untagged manifest after which it gets purged. Defaults to `7`.
    
-   [`trust_policy_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#trust_policy_enabled-1) - (Optional) Boolean value that indicated whether trust policy is enabled. Defaults to `false`.
    
-   [`zone_redundancy_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#zone_redundancy_enabled-1) - (Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to `false`.
    
-   [`export_policy_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#export_policy_enabled-1) - (Optional) Boolean value that indicates whether export policy is enabled. Defaults to `true`. In order to set it to `false`, make sure the `public_network_access_enabled` is also set to `false`.
    
-   [`identity`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#identity-1) - (Optional) An `identity` block as defined below.
    
-   [`encryption`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#encryption-1) - (Optional) An `encryption` block as documented below.
    
-   [`anonymous_pull_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#anonymous_pull_enabled-1) - (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? This is only supported on resources with the `Standard` or `Premium` SKU.
    
-   [`data_endpoint_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#data_endpoint_enabled-1) - (Optional) Whether to enable dedicated data endpoints for this Container Registry? This is only supported on resources with the `Premium` SKU.
    
-   [`network_rule_bypass_option`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#network_rule_bypass_option-1) - (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are `None` and `AzureServices`. Defaults to `AzureServices`.
    

___

The `georeplications` block supports the following:

-   [`location`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#location-2) - (Required) A location where the container registry should be geo-replicated.
    
-   [`regional_endpoint_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#regional_endpoint_enabled-1) - (Optional) Whether regional endpoint is enabled for this Container Registry?
    
-   [`zone_redundancy_enabled`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#zone_redundancy_enabled-2) - (Optional) Whether zone redundancy is enabled for this replication location? Defaults to `false`.
    
-   [`tags`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#tags-2) - (Optional) A mapping of tags to assign to this replication location.
    

___

The `network_rule_set` block supports the following:

-   [`default_action`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#default_action-1) - (Optional) The behaviour for requests matching no rules. Either `Allow` or `Deny`. Defaults to `Allow`
    
-   [`ip_rule`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#ip_rule-1) - (Optional) One or more `ip_rule` blocks as defined below.
    

___

The `ip_rule` block supports the following:

-   [`action`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#action-1) - (Required) The behaviour for requests matching this rule. At this time the only supported value is `Allow`
    
-   [`ip_range`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#ip_range-1) - (Required) The CIDR block from which requests will match the rule.
    

___

An `identity` block supports the following:

-   [`type`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#type-1) - (Required) Specifies the type of Managed Service Identity that should be configured on this Container Registry. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both).
    
-   [`identity_ids`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#identity_ids-1) - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Container Registry.
    

___

The `encryption` block supports the following:

-   [`key_vault_key_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#key_vault_key_id-1) - (Required) The ID of the Key Vault Key.
    
-   [`identity_client_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#identity_client_id-1) - (Required) The client ID of the managed identity associated with the encryption key.
    

___

## [Attributes Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference)

In addition to the Arguments listed above - the following Attributes are exported:

-   [`id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#id-1) - The ID of the Container Registry.
    
-   [`login_server`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#login_server-1) - The URL that can be used to log into the container registry.
    
-   [`admin_username`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#admin_username-1) - The Username associated with the Container Registry Admin account - if the admin account is enabled.
    
-   [`admin_password`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#admin_password-1) - The Password associated with the Container Registry Admin account - if the admin account is enabled.
    
-   [`identity`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#identity-2) - An `identity` block as defined below.
    

___

An `identity` block exports the following:

-   [`principal_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#principal_id-1) - The Principal ID associated with this Managed Service Identity.
    
-   [`tenant_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#tenant_id-2) - The Tenant ID associated with this Managed Service Identity.
    

___

## [Timeouts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#timeouts)

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

-   [`create`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#create-1) - (Defaults to 30 minutes) Used when creating the Container Registry.
-   [`update`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#update-1) - (Defaults to 30 minutes) Used when updating the Container Registry.
-   [`read`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#read-1) - (Defaults to 5 minutes) Used when retrieving the Container Registry.
-   [`delete`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#delete-1) - (Defaults to 30 minutes) Used when deleting the Container Registry.

## [Import](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#import)

Container Registries can be imported using the `resource id`, e.g.

```shell
terraform import azurerm_container_registry.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.ContainerRegistry/registries/myregistry1
```