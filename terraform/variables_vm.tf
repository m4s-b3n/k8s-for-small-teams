variable "vm_name" {
  description = "The name of the Virtual Machine."
  type        = string
  default     = "vm-k8s-for-small-teams"
}

variable "vm_admin_username" {
  description = "The username of the Virtual Machine."
  type        = string
  default     = "azureuser"
}

variable "vm_image_os" {
  description = "The OS image to use for the Virtual Machine."
  type        = string
  default     = "linux"
}

variable "vm_size" {
  description = "The size of the Virtual Machine."
  type        = string
  default     = "Standard_D4s_v3"
}

variable "vm_source_image_reference" {
  description = "The source image reference for the Virtual Machine."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    # see https://documentation.ubuntu.com/azure/en/latest/azure-how-to/instances/find-ubuntu-images/ 
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

variable "vm_os_disk" {
  description = "The OS disk configuration for the Virtual Machine."
  type = object({
    caching                          = string
    storage_account_type             = string
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool)
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string)
    }))
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

variable "vm_data_disks" {
  description = "The data disks configuration for the Virtual Machine."
  type = set(object({
    name                 = string
    storage_account_type = string
    create_option        = string
    attach_setting = object({
      lun                       = number
      caching                   = string
      create_option             = optional(string)
      write_accelerator_enabled = optional(bool)
    })
    disk_encryption_set_id           = optional(string)
    disk_iops_read_write             = optional(number)
    disk_mbps_read_write             = optional(number)
    disk_iops_read_only              = optional(number)
    disk_mbps_read_only              = optional(number)
    logical_sector_size              = optional(number)
    source_uri                       = optional(string)
    source_resource_id               = optional(string)
    storage_account_id               = optional(string)
    image_reference_id               = optional(string)
    gallery_image_reference_id       = optional(string)
    disk_size_gb                     = optional(number)
    upload_size_bytes                = optional(number)
    network_access_policy            = optional(string)
    disk_access_id                   = optional(string)
    public_network_access_enabled    = optional(bool)
    tier                             = optional(string)
    max_shares                       = optional(number)
    trusted_launch_enabled           = optional(bool)
    secure_vm_disk_encryption_set_id = optional(string)
    security_type                    = optional(string)
    hyper_v_generation               = optional(string)
    on_demand_bursting_enabled       = optional(bool)
    encryption_settings = optional(object({
      disk_encryption_key = optional(object({
        secret_url      = string
        source_vault_id = string
      }))
      key_encryption_key = optional(object({
        key_url         = string
        source_vault_id = string
      }))
    }))
  }))
  default = [{
    name                 = "linuxdisk-0"
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = 100
    attach_setting = {
      lun     = 0
      caching = "ReadWrite"
    }
  }]
}

variable "vm_public_ips" {
  description = "The domain name labels of the Virtual Machine."
  type = map(object({
    domain_name_label = string
    primary           = bool
  }))
  default = {
    app = {
      domain_name_label = "app-demo-k8s-for-small-teams"
      primary           = true
    },
    monitoring = {
      domain_name_label = "monitoring-demo-k8s-for-small-teams"
      primary           = false
    }
  }
}