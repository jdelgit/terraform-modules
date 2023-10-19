
resource "azurerm_subnet" "bastion" {
  name                                      = "AzureBastionSubnet"
  resource_group_name                       = var.access_resource_group_name
  virtual_network_name                      = var.access_vnet_name
  address_prefixes                          = var.subnet_address_prefixes
}

resource "azurerm_public_ip" "bastion" {
  name                = var.bastion_publicip_name
  location            = var.access_resource_group_location
  resource_group_name = var.access_resource_group_name
  allocation_method   = var.pubip_allocation_method
  sku                 = var.pubip_sku
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.access_resource_group_location
  resource_group_name = var.access_resource_group_name
  sku                 = var.bastion_sku

  ip_configuration {
    name                 = "bastionip-conf"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
