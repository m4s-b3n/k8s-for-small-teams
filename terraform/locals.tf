locals {
  use_keyvault = (var.keyvault_name != null && var.keyvault_resource_group != null)
}