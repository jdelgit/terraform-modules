variable "resource_group_name" {
  type    = string
  default = "test-rg"
}

variable "location" {
  type        = string
  description = "Location where resource should be deployed"
  default     = "westeurope"
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

variable "vnet_name" {
  description = "Name of virtual network"
  type        = string
  default     = "test-vnet"
}

variable "address_space" {
  description = "VNET address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "network_security_group_name" {
  type    = string
  default = "test-nsg"
}

variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name                                      = string
    address_prefixes                          = list(string)
    private_endpoint_network_policies_enabled = bool
    service_endpoints                         = list(string)
  }))
}

