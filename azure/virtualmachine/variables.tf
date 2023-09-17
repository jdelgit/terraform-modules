variable "resource_group_name" {
  default = "test-rg"
}

variable "resource_group_location" {
  default = "westeurope"
}

variable "tags" {
  default = {
    environment = "test"
    projectCode = "terraform-template"
    invoiceCode = "tf-test"
  }
}

variable "vm_name" {
  default = "test-vm"
}

variable "vm_size" {
  default = "Standard_E4s_v3"
}

variable "admin_name" {
  default = "azureuser"
}

variable "admin_pubkey" {
  default = "ssh-rsa123456"
}

variable "nic_name" {
  default = "test-nic"
}

variable "vm_subnet_id" {
  default = ""
}

variable "vm_nic_config" {
  default = "test-nic-config"
}

variable "vm_private_ip" {
  default = "10.1.2.10"
}

variable "vm_publisher" {
  default = "Debian"
}

variable "vm_offer" {
  default = "debian-10"
}

variable "vm_sku" {
  default = "10"
}

variable "vm_version" {
  default = "latest"
}

variable "vm_storage_account_type" {
  default = "Premium_LRS"
}

variable "vm_caching" {
  default = "ReadWrite"
}

variable "vm_disk_size_gb" {
  default = "30"
}
