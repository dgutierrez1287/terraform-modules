resource "kubernetes_manifest" "external_secret" {
  manifest = yamldecode(templatefile("${path.module}/templates/external-secret.yaml.tmpl", {
    secret_name = var.secret_name,
    secret_namespace = var.secret_namespace,
    secret_type = var.secret_type,
    refresh_interval = var.refresh_interval,
    secret_store_name = var.secret_store_name,
    secret_store_type = var.secret_store_type,
    creation_policy = var.creation_policy,
    vault_key = var.vault_key,
    secret_props = var.secret_props
  }))
}
