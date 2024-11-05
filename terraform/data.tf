data "cloudinit_config" "this" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-config.yaml.tpl", {
      vm_username        = var.vm_admin_username
      vnet_address_space = var.vnet_address_space
      monitoring_fqdn    = azurerm_public_ip.monitoring.fqdn
      branch             = var.branch
    })
  }
}