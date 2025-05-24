locals {
  local_zones = [
    for k, v in var.local_dns_config : {
      zone = v.name
      server1 = v.dns_server1
      server2 = v.dns_server2
    }
  ]
}

resource "kubernetes_config_map_v1_data" "coredns_local_patch" {
  metadata {
    name = "coredns"
    namespace = "kube-system"   
  }

  data = {
    Corefile = templatefile("${path.module}/templates/coredns-corefile.tmpl", {
      local_dns_zones = local.local_zones, 
      local_cluster_dns_zone = var.local_cluster_dns_zone,
      upstream_dns_servers = var.upstream_dns_servers
    })
  }
  force = true
}
