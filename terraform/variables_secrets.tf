variable "keyvault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
  default     = null
}

variable "keyvault_resource_group" {
  description = "Name of the Azure Resource Group containing the Key Vault"
  type        = string
  default     = null
}

variable "keyvault_secret_name_fqdn" {
  description = "Name of the secret containing the FQDN of the monitoring VM"
  type        = string
  default     = "k8s-for-small-teams-fqdn"
}

variable "keyvault_secret_name_username" {
  description = "Name of the secret containing the username of the monitoring VM"
  type        = string
  default     = "k8s-for-small-teams-username"
}

variable "keyvault_secret_name_key" {
  description = "Name of the secret containing the private key of the monitoring VM"
  type        = string
  default     = "k8s-for-small-teams-key"
}
