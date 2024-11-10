variable "azure_application_name" {
  description = "Name of the Azure AD application"
  type        = string
  default     = "k8s-for-small-teams"
}

variable "azure_application_api_access" {
  description = "List of API access permissions for the Azure AD application"
  type = list(object({
    api_name          = string
    role_permissions  = list(string)
    scope_permissions = list(string)
  }))
  default = []
}

variable "azure_service_principal_subscription_roles" {
  description = "List of subscription roles to assign to the service principal"
  type        = set(string)
  default     = ["Contributor"] # allow access to the subscription and the subscriptions RBAC
}

variable "github_repository_owner" {
  description = "Owner of the GitHub repository"
  type        = string
  default     = "m4s-b3n"
}

variable "github_repository_name" {
  description = "Name of the GitHub repository"
  type        = string
  default     = "k8s-for-small-teams"
}

variable "github_repository_branches" {
  description = "List of branches to create federated credentials for"
  type        = set(string)
  default     = ["main"]
}

variable "github_repository_tags" {
  description = "List of tags to create federated credentials for"
  type        = set(string)
  default     = []
}

variable "github_repository_environments" {
  description = "List of environments to create federated credentials for"
  type        = set(string)
  default     = ["deploy", "cleanup"]
}

variable "github_repository_pull_request" {
  description = "Create federated credentials for pull requests"
  type        = bool
  default     = true
}

variable "github_app" {
  description = "GitHub token for writing the secret"
  type = object({
    id              = string
    installation_id = string
    private_key     = string
  })
  sensitive = true
  default   = null
}