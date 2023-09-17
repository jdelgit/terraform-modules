
resource "azurerm_kubernetes_cluster" "cluster" {
  name                            = var.cluster_name
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  dns_prefix                      = var.cluster_dns_prefix
  private_cluster_enabled         = var.private_cluster_enabled
  kubernetes_version              = var.kubernetes_version
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges
  sku_tier                        = var.cluster_sku_tier
  public_network_access_enabled   = var.public_network_access_enabled

  default_node_pool {
    name                = "default"
    enable_auto_scaling = var.enable_auto_scaling
    node_count          = var.node_count
    min_count           = var.enable_auto_scaling ? var.min_count : null
    max_count           = var.enable_auto_scaling ? var.max_count : null
    vm_size             = var.cluster_node_size
    os_disk_size_gb     = var.cluster_node_os_disk_size_gb
    zones               = var.zones
    tags                = var.tags
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
