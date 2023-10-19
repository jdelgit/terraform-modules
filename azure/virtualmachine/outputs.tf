output "vm_nic_interface_id" {
  value = azurerm_network_interface.nic.id
}

output "vm_public_ip" {
  value = length(azurerm_public_ip.vm_pip) > 0 ? azurerm_public_ip.vm_pip[0].ip_address : null
}

output "ssh_public_key" {
  value = length(module.ssh_setup) > 0 ? module.ssh_setup[0].public_key : null
}

output "ssh_private_key_name" {
  value = length(module.ssh_setup) > 0 ? module.ssh_setup[0].ssh_private_key_name : null
}

output "ssh_private_key_keyvault_name" {
  value = length(module.ssh_setup) > 0 ? module.ssh_setup[0].keyvault_name : null
}

output "ssh_private_key_keyvault_id" {
  value = length(module.ssh_setup) > 0 ? module.ssh_setup[0].keyvault_id : null
}
