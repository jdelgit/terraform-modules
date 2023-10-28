
resource "azurerm_kubernetes_cluster" "cluster" {
  name                              = var.cluster_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  dns_prefix                        = var.cluster_dns_prefix
  private_cluster_enabled           = var.private_cluster_enabled
  run_command_enabled               = var.run_command_enabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  kubernetes_version                = var.kubernetes_version
  sku_tier                          = var.cluster_sku_tier
  local_account_disabled            = var.local_account_disabled
  oidc_issuer_enabled               = var.oidc_issuer_enabled
  workload_identity_enabled         = var.workload_identity_enabled

  api_server_access_profile {
    authorized_ip_ranges     = var.private_cluster_enabled ? null : var.authorized_ip_ranges
    vnet_integration_enabled = var.vnet_integration_enabled
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = var.keyvault_provider_secrets_rotation_enabled
    secret_rotation_interval = var.keyvault_provider_secrets_rotation_interval
  }

  default_node_pool {
    name                        = "default"
    temporary_name_for_rotation = var.default_node_temporary_name_for_rotation
    vm_size                     = var.default_node_size
    node_count                  = var.default_node_pool_node_count
    enable_auto_scaling         = var.enable_auto_scaling
    enable_host_encryption      = var.default_node_pool_enable_host_encryption
    min_count                   = var.enable_auto_scaling ? var.default_node_pool_min_count : null
    max_count                   = var.enable_auto_scaling ? var.default_node_pool_max_count : null
    os_disk_size_gb             = var.default_node_os_disk_size_gb
    vnet_subnet_id              = var.vnet_subnet_id
    zones                       = var.zones
    tags                        = var.tags
  }

  network_profile {
    load_balancer_sku = var.load_balancer_sku
    network_plugin    = var.network_plugin
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.cluster_admin_group_ids
    azure_rbac_enabled     = var.cluster_azure_rbac_enabled
  }

  identity {
    type = "SystemAssigned"
  }

  storage_profile {
    blob_driver_enabled         = var.enable_azure_blob_storage
    disk_driver_enabled         = var.enable_azure_disk_storage
    file_driver_enabled         = var.enable_azure_file_storage
    disk_driver_version         = var.azure_disk_driver_version
    snapshot_controller_enabled = var.snapshot_controller_enabled
  }

  lifecycle {
    ignore_changes = [kubernetes_version]
  }

  tags = var.tags
}
