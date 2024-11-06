module "github-oidc" {
  source  = "infinite-automations/github-oidc/azuread"
  version = "1.1.0"

  azure_application_name                     = var.azure_application_name
  azure_application_api_access               = var.azure_application_api_access
  azure_service_principal_subscription_roles = var.azure_service_principal_subscription_roles
  github_repository_owner                    = var.github_repository_owner
  github_repository_name                     = var.github_repository_name
  github_repository_branches                 = var.github_repository_branches
  github_repository_tags                     = var.github_repository_tags
  github_repository_environments             = var.github_repository_environments
  github_repository_pull_request             = var.github_repository_pull_request
}