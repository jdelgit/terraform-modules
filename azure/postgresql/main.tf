# create postgresql server
resource "azurerm_postgresql_server" "postgresql_server" {
  name                = var.postgresql_server_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  administrator_login          = var.database_admin_user
  administrator_login_password = var.database_admin_password

  sku_name   = var.sku_name
  version    = var.database_version
  storage_mb = var.database_storage_mb

  backup_retention_days = var.backup_retention_days
  auto_grow_enabled     = var.auto_grow_enabled

  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
  tags                             = var.tags
}

# create private endpoint for the postgresql server
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.postgresql_server_private_endpoint_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  subnet_id           = var.vm_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = var.postgresql_server_private_endpoint_name
    private_connection_resource_id = azurerm_postgresql_server.postgresql_server.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
}
