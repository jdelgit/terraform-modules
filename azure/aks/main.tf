
resource "azurerm_kubernetes_cluster" "cluster" {
  name                            = var.cluster_name
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  dns_prefix                      = var.cluster_dns_prefix
  private_cluster_enabled         = var.private_cluster_enabled
  kubernetes_version              = var.kubernetes_version
  sku_tier                        = var.cluster_sku_tier

  api_server_access_profile {
    authorized_ip_ranges    = var.private_cluster_enabled ? null : var.authorized_ip_ranges
    vnet_integration_enabled = false
  }

  default_node_pool {
    name                = "default"
    vm_size             = var.cluster_node_size
  }

  network_profile {
    load_balancer_sku = var.load_balancer_sku
    network_plugin    = var.network_plugin

  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.cluster_admin_group_ids
    azure_rbac_enabled     = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}


resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  vm_size               = var.cluster_node_size
  vnet_subnet_id        = var.vnet_subnet_id
  node_count            = var.node_count
  enable_auto_scaling   = var.enable_auto_scaling
  min_count             = var.enable_auto_scaling ? var.min_count : null
  max_count             = var.enable_auto_scaling ? var.max_count : null
  os_disk_size_gb       = var.cluster_node_os_disk_size_gb
  zones                 = var.zones
  tags                  = var.tags
}