output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
