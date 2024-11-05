variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
  default     = "North Europe"
}

variable "tags" {
  description = "A map of tags that will be added to all resources."
  type        = map(string)
  default = {
    environment = "dev"
    project     = "k8s-for-small-teams"
  }
}

variable "branch" {
  description = "The branch of the git repository to deploy."
  type        = string
  default     = "main"
}