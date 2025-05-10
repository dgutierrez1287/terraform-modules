resource "kubernetes_manifest" "longhorn_norep" {
  manifest = yamldecode(templatefile("${path.module}/templates/longhorn-norep.yaml.tmpl", {
    longhorn_namespace = var.longhorn_namespace  
  }))
}
