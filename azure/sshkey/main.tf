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

resource "azurerm_key_vault_secret" "ssh_secret" {
  name         = "${var.ssh_key_name}-key"
  value        = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey
  key_vault_id = var.keyvault_store_id
}
