output "keyvault_name" {
  value = azurerm_key_vault.kv.name
}

output "keyvault_id" {
  value = azurerm_key_vault.kv.id
}

output "managed_identity" {
  value = azurerm_user_assigned_identity.managed_identity
}