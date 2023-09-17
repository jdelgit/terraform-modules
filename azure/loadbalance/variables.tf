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

variable "loadbalancer_name" {
    default = "test-loadbalancer"
}

variable "loadbalancer_public_ip_name" {
    default = "test-loadbalancer-pip"
}

variable "loadbalancer_public_ip_method" {
    default = "Dynamic"
}

variable "loadbalancer_backend_pool_name" {
    default = "test-loadbalancer-backend-pool"
}

variable "backend_address_pool_association_name" {
    default = "test-loadbalancer-backend-pool-asc"
}

variable "webmanager_public_ip_name" {
    default = "webmanager-pip"
}
variable "webmanager_public_ip_method" {
    default = "Dynamic"
}

variable "vm_nic_interface_id" {
  default = "test-vm-subnet-nic"
}

variable "vm_nic_config" {
  default = "test-vm-subnet-nic-config"
}