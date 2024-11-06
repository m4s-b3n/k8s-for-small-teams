locals {
  store_secrets = (var.keyvault_name != null && var.keyvault_resource_group != null)
}