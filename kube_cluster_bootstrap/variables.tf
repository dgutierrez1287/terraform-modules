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
