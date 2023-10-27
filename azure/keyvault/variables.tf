variable "keyvault_name" {
  type    = string
  default = "tf-kv"
}


variable "location" {
  description = "Location where resource should be deployed"
  type        = string
  default     = "westeurope"
}

variable "keyvault_sku" {
  description = "SKU used for keyvault"
  type        = string
  default     = "standard"
}


variable "resource_group_name" {
  type    = string
  default = "tf-example-rg"
}

variable "enabled_for_disk_encryption" {
  description = "Enable disk encryption for keyvault"
  type        = bool
  default     = true
}


variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "123456798"
}


variable "soft_delete_retention_days" {
  description = "Number of days to keep item after soft-deletion"
  type        = number
  default     = 7
}


variable "purge_protection_enabled" {
  description = "Allow purging of items"
  type        = bool
  default     = true
}


variable "enable_rbac_authorization" {
  description = "Enable RBAC for access to keyvault"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Allow public access to keyvault"
  type        = bool
  default     = false
}

variable "network_bypass" {
  description = "Allow service to bypass network restrictions"
  type        = string
  default     = "AzureServices" # AzureServices / None
}

variable "allowed_ips" {
  description = "IPs allowed to publicly access keyvault"
  type        = list(string)
  default     = [""]
}

variable "network_default_action" {
  description = "Default premission action"
  type        = string
  default     = "Deny"
}


variable "access_policies" {
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

variable "virtual_network_subnet_ids" {
  description = "IDs of subnets to connect to keyvault"
  type  = list(string)
}

variable "network_acls" {
  description = "Keyvault network policies"
  type = object({
    bypass = string
    default_action = string
    ip_rules = list(string)

  })
  default = {
    bypass = "None"
    default_action = "Deny"
    ip_rules = [""]
  }
}

variable "create_private_dns_zone" {
  description = "Optionally create private DNS zone for keyvault"
  type        = bool
}


variable "create_private_endpoint" {
  description = "Create private endpoint to access keyvault"
  type        = bool
  default     = true
}

variable "private_dns_zone_ids" {
  description = "Private DNS zones in which to make keyvault available"
  type        = list(string)
  default     = [""]
}

variable "private_endpoint_subnet_id" {
  description = "Subnet to deploy keyvault private endpoint"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Resource tags"
  type = object({
    environment = string
    projectCode = string
    invoiceCode = string
  })
  default = {
    environment = "dev"
    projectCode = "terraform-template"
    invoiceCode = "tf-test"
  }
}
