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
  location  = var.location
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
  count                       = var.create_keyvault == true ? 1 : 0
  source                      = "../keyvault"
  keyvault_name               = "${var.ssh_key_name}-kv"
  keyvault_sku                = var.keyvault_sku
  location                    = var.keyvault_location
  resource_group_name         = var.keyvault_resource_group_name
  tenant_id                   = var.tenant_id
  create_private_dns_zone     = var.keyvault_create_private_dns_zone
  create_private_endpoint     = var.keyvault_create_private_endpoint
  enabled_for_disk_encryption = var.keyvault_enabled_for_disk_encryption
  access_policies             = var.keyvault_access_policies
  purge_protection_enabled    = var.keyvault_purge_protection_enabled
  soft_delete_retention_days  = var.keyvault_soft_delete_retention_days
  tags                        = var.tags
}


resource "azurerm_key_vault_secret" "ssh_secret" {
  name         = "${var.ssh_key_name}-key"
  value        = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey
  key_vault_id = var.create_keyvault == true ? module.keyvault[0].keyvault_id : var.keyvault_store_id
  depends_on   = [module.keyvault]
}
