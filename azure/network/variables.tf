variable "resource_group_name" {
  default = "test-rg"
}

variable "resource_group_location" {
  default = "West Europe"
}

variable "tags" {
  default = {
    environment = "test"
    projectCode = "terraform-template"
    invoiceCode = "tf-test"
  }
}

variable "vnet_name" {
  default = "test-vnet"
}

variable "vnet_address_space" {
  default = "10.31.0.0/16"
}

variable "vm_subnet_name" {
  default = "vm-test-subnet"
}

variable "vm_subnet_address_prefix" {
  default = "10.31.2.0/24"
}


variable "network_security_group_name" {
  default = "test-nsg"
}

variable "nsgrules" {
  default = {}
}
