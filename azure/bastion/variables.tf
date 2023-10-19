variable "access_resource_group_name" {
  default = "testrg"
}

variable "access_resource_group_location" {
  default = "westeurope"
}

variable "access_vnet_name" {
  default = "testvnet"
}

variable "subnet_address_prefixes" {
  default = ["10.10.1.0/24"]
}

variable "bastion_publicip_name" {
  default = "bastion-pip"
}

variable "pubip_allocation_method" {
  default = "Static"
}

variable "pubip_sku" {
  default = "Standard"
}

variable "bastion_name" {
  default = "access-bastion"
}

variable "bastion_sku" {
  default = "Standard"
}
