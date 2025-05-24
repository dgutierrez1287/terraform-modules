resource "kubernetes_manifest" "rwx_longhorn_volume" {
  manifest = yamldecode(templatefile("${path.module}/templates/longhorn-rwx-volume.yaml.tmpl", {
    volume_name = var.volume_name,
    volume_namespace = var.volume_namespace,
    volume_class_name = var.volume_class_name,
    volume_size = var.volume_size
  }))
}
