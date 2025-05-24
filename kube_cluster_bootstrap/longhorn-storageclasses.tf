resource "kubernetes_manifest" "longhorn_norep" {
  manifest = yamldecode(templatefile("${path.module}/templates/longhorn-norep.yaml.tmpl", {
    longhorn_namespace = var.longhorn_namespace  
  }))
}

resource "kubernetes_manifest" "longhorn_rwx" {
  manifest = yamldecode(templatefile("${path.module}/templates/longhorn-rwx.yaml.tmpl", {
    longhorn_namespace = var.longhorn_namespace
  }))
}

resource "kubernetes_manifest" "longhorn_rwx_norep" {
  manifest = yamldecode(templatefile("${path.module}/templates/longhorn-rwx-norep.yaml.tmpl", {
    longhorn_namespace = var.longhorn_namespace
  }))
}
