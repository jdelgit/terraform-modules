output "vm_nic_interface_id" {
  value = azurerm_network_interface.nic.id
}

output "vm_public_ip" {
  value = azurerm_public_ip.vm_pip[0].ip_address
}

output "ssh_public_key" {
  value = module.ssh_setup[0].public_key
}

output "ssh_private_key_name" {
  value = module.ssh_setup[0].ssh_private_key_name
}

output "ssh_private_key_keyvault_name" {
  value = module.ssh_setup[0].keyvault_name
}

output "ssh_private_key_keyvault_id" {
  value = module.ssh_setup[0].keyvault_id
}
