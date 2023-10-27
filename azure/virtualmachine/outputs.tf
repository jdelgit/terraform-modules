output "vm_nic_interface_id" {
  value = azurerm_network_interface.nic.id
}

output "vm_public_ip" {
  value = length(azurerm_public_ip.vm_pip) > 0 ? azurerm_public_ip.vm_pip[0].ip_address : null
}
