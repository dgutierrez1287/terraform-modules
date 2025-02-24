resource "kubernetes_service_account" "vault_auth" {
  metadata {
    name = "vault-auth"
  }
}

resource "kubernetes_cluster_role_binding" "vault_role" {
  metadata {
    name = "role-tokenreview-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "system:auth-delegator"
  }
  subject {
    kind = "ServiceAccount"
    name = "vault-auth"
    namespace = "default"
  }
}

resource "kubernetes_secret" "vault_auth_token" {
  metadata {
    name = "vault-auth-token"
    namespace = kubernetes_service_account.vault_auth.metadata[0].namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.vault_auth.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
}

data "kubernetes_secret" "vault_auth_token" {
  metadata {
    name = kubernetes_secret.vault_auth_token.metadata[0].name
    namespace = kubernetes_service_account.vault_auth.metadata[0].namespace
  }
}

resource "vault_auth_backend" "cluster_auth_backend" {
  type = "kubernetes"
  path = "${var.cluster_name}-cluster"
}

resource "vault_kubernetes_auth_backend_config" "cluster_auth_config" {
  backend = vault_auth_backend.cluster_auth_backend.path
  kubernetes_host = "https://${var.cluster_vip}:${var.cluster_api_port}"
  kubernetes_ca_cert = var.cluster_ca_cert
  token_reviewer_jwt = data.kubernetes_secret.vault_auth_token.data["token"]
  issuer = "https://kubernetes.default.svc.cluster.local"
}

