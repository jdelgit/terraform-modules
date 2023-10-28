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

  dynamic "access_policy" {
    for_each = var.access_policies
    content {
      tenant_id               = var.tenant_id
      object_id               = access_policy.value["access_policy_group_object_id"]
      key_permissions         = access_policy.value["key_permissions"]
      secret_permissions      = access_policy.value["secret_permissions"]
      storage_permissions     = access_policy.value["storage_permissions"]
      certificate_permissions = access_policy.value["certificate_permissions"]
    }
  }

  network_acls {
    bypass                     = var.enabled_for_disk_encryption == true ? "AzureServices" : var.network_acls.bypass
    default_action             = var.network_acls.default_action
    ip_rules                   = var.network_acls.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  sku_name = var.keyvault_sku
  tags     = var.tags
}

resource "azurerm_private_dns_zone" "kv" {
  count               = var.create_private_dns_zone == true ? 1 : 0
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "pe_kv" {
  count               = var.create_private_endpoint == true ? 1 : 0
  name                = "pe-${var.keyvault_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  tags = var.tags
  private_dns_zone_group {
    name                 = "${var.keyvault_name}privatednszonegroup"
    private_dns_zone_ids = var.create_private_dns_zone == true ? [azurerm_private_dns_zone.kv[0].id] : var.private_dns_zone_ids
  }

  private_service_connection {
    name                           = "pse-${var.keyvault_name}"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }
}


############################
# Create Managed Identity resources
# Based of https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-identity-access
resource "azurerm_user_assigned_identity" "managed_identity" {
  count               = var.create_managed_identity == true ? 1 : 0
  name                = "${var.keyvault_name}-kv-mngd-id"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "managed_identity_keyvault" {
  count                = var.create_managed_identity == true ? 1 : 0
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.managed_identity[0].principal_id
}

resource "azurerm_federated_identity_credential" "app" {
  count               = var.create_managed_identity == true ? 1 : 0
  name                = "${var.keyvault_name}-fed-cred"
  resource_group_name = var.resource_group_name
  audience            = var.managed_identity_fed_credential_audience
  issuer              = var.managed_identity_fed_credential_oidc_issuer_url
  subject             = var.managed_identity_fed_credential_subject
  parent_id           = azurerm_user_assigned_identity.managed_identity[0].id
}
