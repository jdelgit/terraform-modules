variable "resource_group_name" {
  type = string
}

variable "location" {
  description = "Location where resource should be deployed"
  type        = string
  default     = "westeurope"
}

variable "resource_group_id" {
  type    = string
  default = "123456789"
}

variable "tags" {
  description = "Resource tags"
  type = object({
    environment = string
    projectCode = string
    invoiceCode = string
  })
}

variable "create_public_ip" {
  description = "Optionally create public IP for Virtualmachine"
  type        = bool
}

variable "pubip_sku" {
  description = "SKU of the public IP for the Virtualmachine"
  type        = string
  default     = "Basic" # Basic / Standard
}

variable "privateip_allocation_method" {
  description = "Allocation method for IP address"
  type        = string
  default     = "Static" # Static / Dynamic
}

variable "pubip_allocation_method" {
  description = "Allocation method for IP address"
  type        = string
  default     = "Static" # Static / Dynamic
}

variable "create_network" {
  description = "Optionally create network for Virtualmachine"
  type        = bool
}

variable "vm_name" {
  description = "Name of Virtualmachine"
  type        = string
  default     = "test-vm"
}

variable "vm_size" {
  description = "Size of the Virtualmachine"
  type        = string
  default     = "Standard_D2_v2"
}

variable "admin_ssh_data" {
  description = "Data for admin login"
  type = list(object({
    username   = string
    public_key = string
  }))
}

variable "vm_subnet_id" {
  description = "ID of existing subnet to place Virtualmachine"
  type        = string

}

variable "vnet_address_space" {
  description = "Virtual network for Virtualmachine"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet" {
  type = object({
    name                                      = string
    address_prefixes                          = list(string)
    service_endpoints                         = list(string)
    private_endpoint_network_policies_enabled = bool
  })
  default = {
    name : "vm-subnet"
    address_prefixes : ["10.0.0.0/24"]
    service_endpoints = null
    private_endpoint_network_policies_enabled : true
  }
}

variable "vm_private_ip" {
  description = "Private IP to allocate to Virtualmachine"
  type        = string
  default     = null
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
  default = "Standard_LRS"
}

variable "vm_caching" {
  default = "ReadWrite"
}

variable "vm_disk_size_gb" {
  description = "Virtualmachine OS disk size"
  type        = string
  default     = "30"
}

variable "nsgrules" {
  type = object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefixes    = list(string)
    destination_address_prefix = string
  })
  default = {
    name                       = null
    priority                   = null
    direction                  = null
    access                     = null
    protocol                   = null
    source_port_range          = null
    destination_port_ranges    = null
    source_address_prefixes    = null
    destination_address_prefix = null
  }
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "123456798"
}
