variable "cluster_name" {
  type    = string
  default = "example-k8s-aks"
}

variable "cluster_admin_group_ids" {
  description = "List of AAD group IDs to assign as admins of cluster"
  type        = list(string)
  default     = [""]
}

variable "default_node_os_disk_size_gb" {
  description = "Cluster nodes OS disk size"
  type        = string
  default     = "30"
}

variable "default_node_size" {
  description = "Azure node size for cluster nodes"
  type        = string
  default     = "Standard_D2_v2"
}

variable "cluster_dns_prefix" {
  description = "Prefix to use for Cluster DNS resource"
  type        = string
  default     = "devk8s"
}

variable "cluster_azure_rbac_enabled" {
  description = "Enable RBAC on AKS cluster"
  type        = bool
  default     = true
}


variable "vnet_subnet_id" {
  description = "ID of user created subnet to use for cluster"
  type        = string
  default     = ""
}

variable "vnet_integration_enabled" {
  description = "Enable cluster vnet integration"
  type        = bool
  default     = false
}

variable "location" {
  description = "Location to deploy cluster"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  type    = string
  default = "k8s-resourcegroup"
}

variable "enable_auto_scaling" {
  description = "Enable cluster node autoscaling"
  type        = bool
  default     = false
}

variable "default_node_pool_node_count" {
  description = "Initial number of nodes in cluster"
  type        = number
  default     = 1
}

variable "default_node_pool_max_count" {
  description = "Minimum number of nodes in cluster"
  type        = number
  default     = 3
}

variable "default_node_pool_min_count" {
  description = "Maximum number of nodes in cluster"
  type        = number
  default     = 1
}

variable "default_node_temporary_name_for_rotation" {
  description = "Name used for spinning up and switching nodes"
  type        = string
  default     = "tmpvmrotate"
}

variable "private_cluster_enabled" {
  description = "Enable Private cluster and create private endpoint"
  type        = bool
  default     = false
}

variable "kubernetes_version" {
  description = "Kubernetes version used in cluster"
  type        = string
  default     = "1.27.1"
}

variable "load_balancer_sku" {
  description = "SKU for AKS public loadbalancer"
  type        = string
  default     = "standard"
}

variable "network_plugin" {
  description = "Network plugin to use for kubernetes"
  default     = "kubenet"
}

variable "authorized_ip_ranges" {
  description = "CIDRs allowed to access kube-apiserver"
  type        = list(string)
  default     = [""]
}

variable "zones" {
  description = "Availability zones for cluster"
  type        = list(string)
  default     = [""]
}

variable "cluster_sku_tier" {
  description = "SKU tier for cluster"
  type        = string
  default     = "Free"
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


