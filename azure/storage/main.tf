

# Storage account for Blob storage
resource "azurerm_storage_account" "storageaccount" {
  name                     = var.storageaccount_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.storage_account_tier
  account_kind             = var.storage_account_kind
  account_replication_type = var.storage_account_replication_type
  tags                     = var.tags

  network_rules {
    default_action = var.storage_default_action
    ip_rules       = var.storage_allowed_ips
  }
}

resource "azurerm_private_endpoint" "storage-endpoint" {
  name                = var.storage_private_endpoint_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_storage_account.storageaccount.id
    is_manual_connection           = false
  }
}
