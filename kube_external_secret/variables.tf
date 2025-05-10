variable "secret_name" {
  description = "The name of the kubernetes secret"
  type = string
}

variable "secret_namespace" {
  description = "The namespace for the kubernetes secret"
  type = string
}

variable "refresh_interval" {
  description = "The refresh interval for the secret"
  type = string
  default = "15s"
}

variable "secret_store_name" {
  description = "The name for the secret store"
  type = string 
}

variable "secret_store_type" {
  description = "The type of the secret store"
  type = string
  default = "ClusterSecretStore"

  validation {
    condition = var.secret_store_type == "ClusterSecretStore" || var.secret_store_type == "SecretStore"
    error_message = "secret_store_type must be either 'ClusterSecretStore' or 'SecretStore'"
  }
}

variable "creation_policy" {
  description = "The creation policy for the external secret"
  type = string
  default = "Owner"

  validation {
    condition = contains(["Owner", "Merge", "None"], var.creation_policy)
    error_message = "creation_policy must be Owner, Merge, or None"
  }
}

variable "vault_key" {
  description = "The vault key for the secret"
  type = string
}

variable "secret_props" {
  description = "A map of key and property pairs for the key"
  type = list(map(string))
}

variable "secret_type" {
  description = "The type of secret for kubernetes"
  type = string
  default = "Opaque"

  validation {
    condition = contains([
      "Opaque",
      "kubernetes.io/basic-auth",
      "kubernetes.io/ssh-auth",
      "kubernetes.io/tls",
      "kubernetes.io/dockerconfigjson",
      "bootstrap.kubernetes.io/token"
    ], var.secret_type)
    error_message = "secret_type is not a valid supported type"
  }
}
