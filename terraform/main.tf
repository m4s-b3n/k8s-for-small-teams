resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.location
}

module "network" {
  source              = "Azure/network/azurerm"
  version             = "5.3.0"
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.this.name
  use_for_each        = var.vnet_use_for_each
  address_space       = var.vnet_address_space
  subnet_names        = var.vnet_subnet_names
  subnet_prefixes     = var.vnet_subnet_prefixes
  tags                = var.tags
  depends_on          = [azurerm_resource_group.this]
}

module "network-security-group" {
  source              = "Azure/network-security-group/azurerm"
  version             = "4.1.0"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  security_group_name = var.nsg_name
  predefined_rules = [
    {
      name     = "HTTPS"
      priority = 100
    },
    {
      name     = "SSH"
      priority = 101
    }
  ]
  tags       = var.tags
  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = one(module.network.vnet_subnets)
  network_security_group_id = module.network-security-group.network_security_group_id
}

resource "azurerm_public_ip" "this" {
  for_each            = var.vm_public_ips
  allocation_method   = "Dynamic"
  location            = var.location
  name                = "pip-${each.key}"
  resource_group_name = azurerm_resource_group.this.name
  domain_name_label   = each.value.domain_name_label
  tags                = var.tags
}

resource "tls_private_key" "this" {
  algorithm   = var.ssh_algorithm
  rsa_bits    = var.ssh_rsa_bits
  ecdsa_curve = var.ssh_ecdsa_curve
}

resource "local_file" "ssh_private_key" {
  filename        = local.ssh_key_file
  content         = tls_private_key.this.private_key_pem
  file_permission = "0400"
}

module "virtual-machine" {
  source              = "Azure/virtual-machine/azurerm"
  version             = "1.1.0"
  image_os            = var.vm_image_os
  os_simple           = var.vm_os_simple
  location            = var.location
  name                = var.vm_name
  os_disk             = var.vm_os_disk
  resource_group_name = azurerm_resource_group.this.name
  size                = var.vm_size
  subnet_id           = one(module.network.vnet_subnets)
  data_disks          = var.vm_data_disks
  new_network_interface = {
    ip_forwarding_enabled = false
    ip_configurations     = local.vm_ip_configurations
  }
  admin_username = var.vm_admin_username
  admin_ssh_keys = [
    {
      public_key = tls_private_key.this.public_key_openssh
    }
  ]
  tags = var.tags
}