output "public_key" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
}

output "keyvault_name" {
  value = module.keyvault[0].keyvault_name
}

output "keyvault_id" {
  value = module.keyvault[0].keyvault_id
}

output "ssh_private_key_name" {
  value = azurerm_key_vault_secret.ssh_secret[0].name
}
