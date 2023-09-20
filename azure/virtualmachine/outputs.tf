output "vm_nic_interface_id" {
  value = azurerm_network_interface.nic.id
}

output "vm_nic_config_name" {
  value = var.vm_nic_config
}


output "vm_public_ip" {
  value = azurerm_public_ip.vm_pip[0].ip_address
}
