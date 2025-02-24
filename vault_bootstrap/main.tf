resource "vault_mount" "main_kv_v2" {
  path = "secrets"
  type = "kv"
  options = { version = "2" }
  description = "Main secrets KV"
}

resource "vault_kv_secret_backend_v2" "main_kv_backend" {
  mount = vault_mount.main_kv_v2.path
  max_versions = var.max_versions
  delete_version_after = var.delete_version_after
  cas_required = var.cas_required
}
