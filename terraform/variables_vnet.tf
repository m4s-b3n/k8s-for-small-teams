variable "vnet_name" {
  description = "The name of the Virtual Network."
  type        = string
  default     = "vnet-k8s-for-small-teams"
}

variable "vnet_use_for_each" {
  description = "Description: Use `for_each` instead of `count` to create multiple resource instances."
  type        = bool
  default     = true
}

variable "vnet_address_space" {
  description = "The address space that is used the Virtual Network."
  type        = string
  default     = "10.0.0.0/27"
}

variable "vnet_subnet_names" {
  description = "The names of the subnets that are used in the Virtual Network."
  type        = list(string)
  default     = ["subnet-virtual-machine"]
}

variable "vnet_subnet_prefixes" {
  description = "The prefixes of the subnets that are used in the Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/27"]
}

variable "nsg_name" {
  description = "The name of the Network Security Group."
  type        = string
  default     = "nsg-virtual-machine"
}