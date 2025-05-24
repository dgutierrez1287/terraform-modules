variable "cluster_name" {
  description = "The name of the cluster"
  type = string
  default = "main"
}

variable "env" {
  description = "The environment"
  type = string
  default = "local"
}

variable "vault_address" {
  description = "The address for the vault instance"
  type = string
}

variable "internal_vault_address" {
  description = "The internal vault address"
  type = string
  default = ""
}

variable "vault_connection_type" {
  description = "If vault is internal for this cluster"
  type = string
  default = "internal"
}

variable "skip_vault_tls" {
  description = "Skip TLS verification for vault"
  type = bool
  default = true
}

variable "vault_secrets_path" {
  description = "The secrets path in vault"
  type = string
  default = "secrets"
}

variable "env_cacert_kube_secret" {
  description = "The kubernetes env for the local ca cert"
  type = string
  default = "local-ca-cert"
}

variable "env_cacert_secret_key" {
  description = "The key for the env ca cert in the kubernetes secret"
  type = string
  default = "ca_cert"
}

variable "env_cacert_secret_namespace" {
  description = "The namespace for the env ca cert secret"
  type = string
}

variable "upstream_dns_servers" {
  description = "The setting for upstream dns servers"
  type = list(string)
  default = ["8.8.8.8", "8.8.4.4"]
}

variable "local_dns_config" {
  description = "The configuration for local DNS"
  type = map(object({
    name = string
    dns_server1 = string
    dns_server2 = string
  }))
}

variable "cluster_ca_cert" {
  description = "The CA certificate for the cluster"
  type = string
}

variable "local_cluster_dns_zone" {
  description = "The local dns zone for the cluster"
  type = string
  default = "cluster.local"
}

variable "cluster_vip" {
  description = "The vip for the kubernetes cluster"
  type = string
}

variable "cluster_api_port" {
  description = "The port for the cluster api server"
  type = string
  default = "6443"
}

variable "longhorn_namespace" {
  description = "The namespace for longhorn in the cluster"
  type = string
  default = "longhorn-system"
}
