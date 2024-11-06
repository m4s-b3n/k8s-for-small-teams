provider "azurerm" {
  features {}
}

provider "github" {
  owner = var.github_repository_owner
  app_auth {
    id              = var.github_app.id
    installation_id = var.github_app.installation_id
    pem_file        = var.github_app.pem_file
  }
}