# Create GitHub secrets for the federated credentials
resource "github_actions_secret" "tenant-id" {
  count           = local.set_secrets ? 1 : 0
  repository      = var.github_repository_name
  secret_name     = "ARM_TENANT_ID"
  plaintext_value = module.github-oidc.tenant_id
}

resource "github_actions_secret" "subscription-id" {
  count           = local.set_secrets ? 1 : 0
  repository      = var.github_repository_name
  secret_name     = "ARM_SUBSCRIPTION_ID"
  plaintext_value = module.github-oidc.subscription_id
}

resource "github_actions_secret" "client-id" {
  count           = local.set_secrets ? 1 : 0
  repository      = var.github_repository_name
  secret_name     = "ARM_CLIENT_ID"
  plaintext_value = module.github-oidc.client_id
}

# Create GitHub environment secrets for the federated credentials
resource "github_actions_environment_secret" "tenant-id" {
  for_each        = local.secret_envs
  repository      = var.github_repository_name
  environment     = each.key
  secret_name     = "ARM_TENANT_ID"
  plaintext_value = module.github-oidc.tenant_id
}

resource "github_actions_environment_secret" "subscription-id" {
  for_each        = local.secret_envs
  repository      = var.github_repository_name
  environment     = each.key
  secret_name     = "ARM_SUBSCRIPTION_ID"
  plaintext_value = module.github-oidc.subscription_id
}

resource "github_actions_environment_secret" "client-id" {
  for_each        = local.secret_envs
  repository      = var.github_repository_name
  environment     = each.key
  secret_name     = "ARM_CLIENT_ID"
  plaintext_value = module.github-oidc.client_id
}