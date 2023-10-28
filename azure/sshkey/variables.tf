variable "ssh_key_name" {
  default = "kangaroo"
}

variable "keyvault_store_id" {
  description = "ID of keyvault to store generated keys"
  type        = string
  default     = null
}

variable "location" {
  description = "Location where resource should be deployed"
  type        = string
  default     = "westeurope"
}

variable "resource_group_id" {
  type    = string
  default = "123456789"
}
