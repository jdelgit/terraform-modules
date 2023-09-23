terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>1.5"
    }
  }
}



resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = var.ssh_key_name
  location  = var.resource_group_location
  parent_id = var.resource_group_id
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}


module "keyvault" {
  count                         = var.create_keyvault == true ? 1 : 0
  source                        = "../keyvault"
  keyvault_name                 = "${var.ssh_key_name}-kv"
  keyvault_sku                  = var.keyvault_sku
  resource_group_location       = var.resource_group_location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  enabled_for_disk_encryption   = var.enabled_for_disk_encryption
  access_policy_group_object_id = var.keyvault_access_group_object_id
  key_permissions               = var.key_permissions
  secret_permissions            = var.secret_permissions
  storage_permissions           = var.storage_permissions
  certificate_permissions       = var.certificate_permissions
  purge_protection_enabled      = var.purge_protection_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
}


resource "azurerm_key_vault_secret" "ssh_secret" {
  count        = var.create_keyvault == true ? 1 : 0
  name         = "${var.ssh_key_name}-key"
  value        = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey
  key_vault_id = module.keyvault[0].keyvault_id
  depends_on   = [module.keyvault]
}
