variable "volume_name" {
  description = "The name for the rwx longhorn volume"
  type = string
}

variable "volume_namespace" {
  description = "The namespace for the volume"
  type = string
}

variable "volume_class_name" {
  description = "The class name for longhorn rwx type"
  type = string
  default = "longhorn-storageclass-rwx"
}

variable "volume_size" {
  description = "The size for the volume"
  type = string
}
