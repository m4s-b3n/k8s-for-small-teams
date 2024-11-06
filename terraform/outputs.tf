output "ssh_fqdn" {
  value = azurerm_public_ip.app.fqdn
}

output "ssh_username" {
  value = module.virtual-machine.vm_admin_username
}

output "ssh_private_key_file" {
  value = var.vm_local_keyfile
}