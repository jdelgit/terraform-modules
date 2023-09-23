resource "azurerm_key_vault" "kv" {
  name                        = var.keyvault_name
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  enable_rbac_authorization   = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled

  sku_name = var.keyvault_sku

  access_policy {
    tenant_id               = var.tenant_id
    object_id               = var.access_policy_group_object_id
    key_permissions         = var.key_permissions
    secret_permissions      = var.secret_permissions
    storage_permissions     = var.storage_permissions
    certificate_permissions = var.certificate_permissions
  }
}
