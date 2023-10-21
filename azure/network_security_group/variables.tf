variable "resource_group_name" {
  type    = string
  default = "test-rg"
}

variable "location" {
  description = "Location where resource should be deployed"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Resource tags"
  type = object({
    environment = string
    projectCode = string
    invoiceCode = string
  })
}


variable "nsg_name" {
  default = "test-nsg"
}

variable "nsgrules" {
  description = "Rules for network security group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name = string
    id   = string
  }))
}

