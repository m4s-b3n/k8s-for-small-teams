data "azurerm_key_vault" "this" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_resource_group
}
