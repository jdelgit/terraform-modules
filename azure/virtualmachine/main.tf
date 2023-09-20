resource "azurerm_public_ip" "vm_pip" {
  count               = var.enable_public_ip == true ? 1 : 0
  name                = "${var.vm_name}-${var.pubip_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = var.pubip_allocation_method
  sku                 = var.pubip_sku
  tags                = var.tags
}

# create a network interface with a static ip
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags                = var.tags

  ip_configuration {
    name                          = var.vm_nic_config
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = var.privateip_allocation_method
    private_ip_address            = var.vm_private_ip
    public_ip_address_id          = azurerm_public_ip.vm_pip[0].id
  }

}

# create the virtual machine
resource "azurerm_linux_virtual_machine" "virtualmachine" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  admin_username      = var.admin_name
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  tags = var.tags

  admin_ssh_key {
    username   = var.admin_name
    public_key = var.admin_pubkey
  }

  os_disk {
    storage_account_type = var.vm_storage_account_type
    caching              = var.vm_caching
    disk_size_gb         = var.vm_disk_size_gb
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  identity {
    type = "SystemAssigned"
  }
}
