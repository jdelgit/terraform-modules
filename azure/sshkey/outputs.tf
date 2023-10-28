output "public_key" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
}

output "private_key_name" {
  value = azurerm_key_vault_secret.ssh_secret.name
}

output "private_key" {
  sensitive = true
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey
}
