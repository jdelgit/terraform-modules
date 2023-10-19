variable "resource_group_name" {
  default = "test-rg"
}

variable "resource_group_location" {
  default = "westeurope"
}

variable "resource_group_id" {
  default = "123456789"
}

variable "tags" {
  default = {
    environment = "test"
    projectCode = "terraform-template"
    invoiceCode = "tf-test"
  }
}

variable "create_public_ip" {
  default = false
}

variable "pubip_sku" {
  default = "Basic"
}

variable "privateip_allocation_method" {
  default = "Static"
}

variable "pubip_allocation_method" {
  default = "Static"
}

variable "create_network" {
  default = false
}

variable "create_ssh_key" {
  default = false
}
variable "create_keyvault" {
  default = false
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


variable "vm_subnet_id" {
  default = ""
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

variable "vnet_address_space" {
  default = "10.31.0.0/16"
}

variable "vm_subnet_address_prefix" {
  default = "10.31.2.0/24"
}

variable "nsgrules" {
  default = {}
}

variable "keyvault_access_group_object_id" {
  default = "123456789"
}

variable "tenant_id" {
  default = "123456798"
}


variable "keyvault_key_permissions" {
  default = ["Get", "List", "Create", "Update"]
}

variable "keyvault_secret_permissions" {
  default = ["Get", "List", "Set"]
}

variable "keyvault_storage_permissions" {
  default = ["Get", "List", "Update"]
}

variable "keyvault_certificate_permissions" {
  default = ["Get", "List", "Create", "Update"]
}
