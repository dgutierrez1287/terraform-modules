variable "env" {
  description = "The environment"
  type = string
  default = "local"
}

variable "max_versions" {
  description = "The max versions of secrets"
  type = number
  default = 5
}

variable "delete_version_after" {
  description = "The amount of time before a version is deleted"
  type = number
  default = 12600
}

variable "cas_required" {
  description = "requiring the cas parameter for writes"
  type = bool
  default = true
}
