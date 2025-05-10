resource "kubernetes_service_account" "external_secrets_sa" {
  metadata {
    name = "external-secrets-sa"
    namespace = "external-secrets"
  }
}

resource "kubernetes_role" "external_secrets_role" {
  metadata {
    name = "external-secrets-role"
    namespace = "external-secrets"
  }

  rule {
    api_groups = [""]
    resources = ["secrets"]
    verbs = ["get", "watch", "list", "create", "update", "delete"]
  }
}

resource "kubernetes_role_binding" "external_secrets_rb" {
  metadata {
    name = "external-secrets-rb"
    namespace = "external-secrets"
  }
  subject {
    kind = "ServiceAccount"
    name = "external-secrets-sa"
    namespace = "external-secrets"
  }
  role_ref {
    kind = "Role"
    name = "external-secrets-role"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "vault_policy" "external_secrets_read_all" {
  name = "${var.cluster_name}-external-secrets-read"

  policy = <<EOT
    path "${var.vault_secrets_path}/*" {
       capabilities = ["read"]
     }
  EOT
}

resource "vault_kubernetes_auth_backend_role" "external_secrets_auth_role" {
  backend = "${var.cluster_name}-cluster"
  role_name = "external-secrets"
  bound_service_account_names = ["external-secrets-sa"]
  bound_service_account_namespaces = ["external-secrets"]
  token_ttl = 3600
  token_policies = ["${var.cluster_name}-external-secrets-read"]
  depends_on = [
    vault_auth_backend.cluster_auth_backend
  ]
}

resource "kubernetes_manifest" "cluster_secret_store" {
  manifest = yamldecode(templatefile("${path.module}/templates/${var.vault_connection_type}-cluster-secret-store.yaml.tmpl", {
    cluster_secret_store_name = "cluster-secret-store"
    vault_server = var.vault_address
    internal_vault_address = var.internal_vault_address
    vault_secrets_path = var.vault_secrets_path
    vault_auth_mount_path = "${var.cluster_name}-cluster"
    vault_role = "external-secrets"
    service_account_name = "external-secrets-sa"
    service_account_namespace = "external-secrets"
    ca_secret_name = var.env_cacert_kube_secret
    ca_secret_key = var.env_cacert_secret_key
    ca_secret_namespace = var.env_cacert_secret_namespace
  }))
} 

