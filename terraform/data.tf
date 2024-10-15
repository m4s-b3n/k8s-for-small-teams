data "azurerm_public_ip" "this" {
  for_each            = var.vm_public_ips
  name                = "pip-${each.key}"
  resource_group_name = azurerm_resource_group.this.name
  depends_on          = [module.virtual-machine]
}