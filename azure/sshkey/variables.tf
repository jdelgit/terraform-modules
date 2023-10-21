variable "ssh_key_name" {
  default = "kangaroo"
}

variable "create_keyvault" {
  description = "Optionally create Keyvault for SSHkey"
  type        = bool
}

variable "keyvault_store_id" {
  description = "ID of keyvault to store generated keys"
  type        = string
  default     = null
}

variable "keyvault_sku" {
  description = "SKU used for keyvault"
  type        = string
  default     = "standard"
}

variable "location" {
  description = "Location where resource should be deployed"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  type    = string
  default = "test-rg"
}

variable "resource_group_id" {
  type    = string
  default = "123456789"
}

variable "keyvault_enabled_for_disk_encryption" {
  description = "Enable disk encryption for keyvault"
  type        = bool
  default     = true
}

variable "keyvault_location" {
  description = "Location where resource should be deployed"
  type        = string
  default     = "westeurope"
}

variable "keyvault_resource_group_name" {
  type    = string
  default = "rg-tf-kg"
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "123456798"
}


variable "keyvault_soft_delete_retention_days" {
  description = "Number of days to keep item after soft-deletion"
  type        = number
  default     = 7
}


variable "keyvault_purge_protection_enabled" {
  description = "Allow purging of items"
  type        = bool
  default     = true
}

variable "keyvault_create_private_dns_zone" {
  description = "Optionally create private DNS zone for keyvault"
  type        = bool
  default     = false
}

variable "keyvault_create_private_endpoint" {
  description = "Create private endpoint to access keyvault"
  type        = bool
  default     = false
}

variable "keyvault_access_policies" {
  description = "Keyvault access policies"
  type = list(object({
    name                          = string
    access_policy_group_object_id = string
    key_permissions               = list(string)
    secret_permissions            = list(string)
    storage_permissions           = list(string)
    certificate_permissions       = list(string)
  }))
  default = [{
    name                          = "default"
    access_policy_group_object_id = "value"
    key_permissions               = ["Get", "List", "Create", "Update"]
    secret_permissions            = ["Get", "List", "Set"]
    storage_permissions           = ["Get", "List", "Update"]
    certificate_permissions       = ["Get", "List", "Create", "Update"]
    }
  ]
}

variable "tags" {
  description = "Resource tags"
  type = object({
    environment = string
    projectCode = string
    invoiceCode = string
  })
}
