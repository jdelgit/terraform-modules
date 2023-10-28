variable "cluster_name" {
  type    = string
  default = "example-k8s-aks"
}

variable "cluster_admin_group_ids" {
  description = "List of AAD group IDs to assign as admins of cluster"
  type        = list(string)
  default     = [""]
}

variable "role_based_access_control_enabled" {
  description = "Enable RBAC for cluster"
  type        = bool
  default     = true
}

variable "oidc_issuer_enabled" {
  description = "Enable or Disable the OIDC issuer URL"
  type        = bool
  default     = false
}

variable "enable_azure_file_storage" {
  description = "Enable Volumes using File storage"
  type = bool
  default = true
}

variable "snapshot_controller_enabled" {
  description = "Enable snapshots for storage"
  type = bool
  default = true
}

variable "enable_azure_blob_storage" {
  description = "Enable Volumes using Blob storage"
  type = bool
  default = true
}

variable "enable_azure_disk_storage" {
  description = "Enable Volumes using AzureDisk storage"
  type = bool
  default = true
}

variable "azure_disk_driver_version" {
  description = "Disk CSI Driver version to be used"
  type = string
  default = "v1"
}

variable "workload_identity_enabled" {
  description = "Enable workload identity"
  type        = bool
  default     = false
}

variable "run_command_enabled" {
  description = "Enable run command on cluster"
  type        = bool
  default     = true
}

variable "default_node_os_disk_size_gb" {
  description = "Cluster nodes OS disk size"
  type        = string
  default     = "100"
}

variable "local_account_disabled" {
  description = "Local user accounts"
  type        = bool
  default     = true

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

variable "keyvault_provider_secrets_rotation_enabled" {
  description = "Enable CSI Secrets Provider"
  type        = bool
  default     = false
}

variable "keyvault_secrets_provider_id" {
  description = "Keyvault ID  of keyvault to manage secrets"
  type        = string
  default     = null
}

variable "keyvault_provider_secrets_rotation_interval" {
  description = "CSI Secrets Provider rotation interval"
  type        = string
  default     = null
}

variable "secrets_provider_secret_identity" {
  description = "Secret Provider access information"
  type = list(object({
    client_id                 = string
    object_id                 = string
    user_assigned_identity_id = string
  }))
  default = [{
    client_id                 = null
    object_id                 = null
    user_assigned_identity_id = null
  }]
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

variable "default_node_pool_enable_host_encryption" {
  description = "Set encryption on host"
  type        = bool
  default     = true

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
  default     = null
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


