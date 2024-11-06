locals {
  set_secrets = nonsensitive(var.github_app != null)
  secret_envs = local.set_secrets ? [] : toset(var.github_repository_environments)
}