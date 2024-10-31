# output "public_ips" {
#   value = {
#     for key, value in azurerm_public_ip.this : key => {
#       ip   = data.azurerm_public_ip.this[key].ip_address
#       fqdn = azurerm_public_ip.this[key].fqdn
#     }
#   }
# }

output "ssh_fqdn" {
  value = try(local.vm_primary_fqdn[0], null)
}

output "ssh_username" {
  value = module.virtual-machine.vm_admin_username
}

output "ssh_private_key_file" {
  value = local.ssh_key_file
}