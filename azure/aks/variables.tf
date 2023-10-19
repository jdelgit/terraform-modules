variable "cluster_name" {
  default = "example-k8s-aks"
}

variable "cluster_admin_group_ids" {
  default = []
}

variable "cluster_node_os_disk_size_gb" {
  default = "30"
}

variable "cluster_node_size" {
  default = "Standard_D2_v2"
}

variable "cluster_dns_prefix" {
  default = "devk8s"
}

variable "vnet_subnet_id" {
  default = "testsubnet"
}

variable "resource_group_location" {
  default = "westeurope"
}

variable "resource_group_name" {
  default = "k8s-resourcegroup"
}

variable "enable_auto_scaling" {
  default = false
}

variable "node_count" {
  default = 1
}

variable "max_count" {
  default = 3
}

variable "min_count" {
  default = 1
}

variable "private_cluster_enabled" {
  default = false
}

variable "kubernetes_version" {
  default = "1.27.1"
}


variable "load_balancer_sku" {
  default = "standard"
}

variable "network_plugin" {
  default = "kubenet"
}

variable "authorized_ip_ranges" {
  default = []
}

variable "zones" {
  default = []
}

variable "public_network_access_enabled" {
  default = true
}

variable "cluster_sku_tier" {
  default = "Free"
}

variable "tags" {
  default = {
    environment = "test"
    projectCode = "terraform-template"
    invoiceCode = "tf-test"
  }
}


