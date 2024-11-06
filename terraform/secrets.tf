resource "azurerm_key_vault_secret" "fqdn" {
  count           = local.store_secrets ? 1 : 0
  name            = var.keyvault_secret_name_fqdn
  value           = azurerm_public_ip.app.fqdn
  key_vault_id    = data.azurerm_key_vault.this.id
  content_type    = "text"
  expiration_date = timeadd(timestamp(), "2160h") # 3 months
}

resource "azurerm_key_vault_secret" "username" {
  count           = local.store_secrets ? 1 : 0
  name            = var.keyvault_secret_name_username
  value           = module.virtual-machine.vm_admin_username
  key_vault_id    = data.azurerm_key_vault.this.id
  content_type    = "text"
  expiration_date = timeadd(timestamp(), "2160h") # 3 months
}

resource "azurerm_key_vault_secret" "key" {
  count           = local.store_secrets ? 1 : 0
  name            = var.keyvault_secret_name_key
  value           = tls_private_key.this.private_key_pem
  key_vault_id    = data.azurerm_key_vault.this.id
  content_type    = "key"
  expiration_date = timeadd(timestamp(), "2160h") # 3 months
}