resource "azurerm_key_vault" "kv" {
  name                          = var.keyvault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = var.enabled_for_disk_encryption
  enable_rbac_authorization     = var.enable_rbac_authorization
  tenant_id                     = var.tenant_id
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled
  public_network_access_enabled = var.public_network_access_enabled

  sku_name = var.keyvault_sku
  tags     = var.tags
}

resource "azurerm_key_vault_access_policy" "kvp" {
  key_vault_id            = azurerm_key_vault.kv.id
  tenant_id               = var.tenant_id
  for_each                = { for policy in var.access_policies : policy.name => policy }
  object_id               = each.value.access_policy_group_object_id
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  storage_permissions     = each.value.storage_permissions
  certificate_permissions = each.value.certificate_permissions
}


resource "azurerm_private_dns_zone" "kv" {
  count               = var.create_private_dns_zone == true ? 1 : 0
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "pe_kv" {
  count               = var.create_private_endpoint == true ? 1 : 0
  name                = format("pe-%s", var.keyvault_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  tags = var.tags
  private_dns_zone_group {
    name                 = "${var.keyvault_name}privatednszonegroup"
    private_dns_zone_ids = var.create_private_dns_zone == true ? [azurerm_private_dns_zone.kv[0].id] : var.private_dns_zone_ids
  }

  private_service_connection {
    name                           = format("pse-%s", var.keyvault_name)
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }
}
