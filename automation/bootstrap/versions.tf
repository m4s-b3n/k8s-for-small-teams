terraform {
  required_version = "~>1.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.53"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.116"
    }
    github = {
      source  = "integrations/github"
      version = "~>6.3"
    }
  }
}