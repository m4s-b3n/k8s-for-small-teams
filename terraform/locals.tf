locals {
  ssh_key_file = "${path.module}/key.pem"

  vm_ip_configurations = [for key, value in var.vm_public_ips : {
    public_ip_address_id = azurerm_public_ip.this[key].id
    primary              = value.primary
    }
  ]

  vm_primary_fqdn = [for key, value in var.vm_public_ips : azurerm_public_ip.this[key].fqdn if value.primary]
}