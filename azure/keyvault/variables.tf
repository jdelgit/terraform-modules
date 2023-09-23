variable "keyvault_name" {
  default = "tf-kv"
}


variable "resource_group_location" {
  default = "tf-kv"
}

variable "keyvault_sku" {
  default = "standard"
}


variable "resource_group_name" {
  default = "tf-example-rg"
}

variable "enabled_for_disk_encryption" {
  default = true
}


variable "tenant_id" {
  default = "123456798"
}


variable "soft_delete_retention_days" {
  default = 7
}


variable "purge_protection_enabled" {
  default = true
}


variable "access_policy_group_object_id" {
  default = "12345679"
}

variable "key_permissions" {
  default = ["Get", "List", "Create", "Update"]
}

variable "secret_permissions" {
  default = ["Get", "List", "Set"]
}

variable "storage_permissions" {
  default = ["Get", "List", "Update"]
}

variable "certificate_permissions" {
  default = ["Get", "List", "Create", "Update"]
}
