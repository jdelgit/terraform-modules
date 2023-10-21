
variable "location" {
  description = "Location where resource should be deployed"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  type    = string
  default = "tf-example-rg"
}

variable "acr_name" {
  type = string
}

variable "acr_sku" {
  type    = string
  default = "Standard" # Basic /Standard / Premium
}

variable "create_private_endpoint" {
  description = "Optionally create private endpoint for ACR"
  type        = bool
}

variable "create_private_dns_zone" {
  description = "Optionally create private DNS zone for ACR"
  type        = bool
}


variable "private_dns_zone_id" {
  description = "Private DNS zone id for ACR"
  type        = string
  default     = ""
}


variable "link_aks_cluster" {
  description = "Optionally create Link AKS cluster to ACR"
  type        = bool
  default     = false
}

variable "aks_cluster_id" {
  description = "AKS cluster to attach ACR"
  type        = string
  default     = ""
}

variable "kublet_object_id" {
  default = ""
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID to place ACR private endpoint"
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
}
