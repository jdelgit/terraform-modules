# create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  address_space       = [var.vnet_address_space]
  tags                = var.tags
}

# Create virtualmachine subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.vm_subnet_address_prefix]

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  security_rule {
    name                         = var.nsgrules.name
    priority                     = var.nsgrules.priority
    direction                    = var.nsgrules.direction
    access                       = var.nsgrules.access
    protocol                     = var.nsgrules.protocol
    source_port_ranges           = var.nsgrules.source_port_ranges
    destination_port_ranges      = var.nsgrules.destination_port_ranges
    source_address_prefixes      = var.nsgrules.source_address_prefixes
    destination_address_prefixes = var.nsgrules.destination_address_prefixes
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id                 = azurerm_subnet.vm_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
