module "network_setup" {
  count               = var.create_network == true ? 1 : 0
  source              = "./../virtual_network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "${var.vm_name}-vnet"
  address_space       = var.vnet_address_space
  subnets             = [var.subnet]
  tags                = var.tags
}

resource "azurerm_public_ip" "vm_pip" {
  count               = var.create_public_ip == true ? 1 : 0
  name                = "${var.vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.pubip_allocation_method
  sku                 = var.pubip_sku
  tags                = var.tags
}

# create a network interface with a static ip
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "${var.vm_name}-nic-config"
    subnet_id                     = var.create_network == true ? module.network_setup[0].vm_subnet_id : var.vm_subnet_id
    private_ip_address_allocation = var.privateip_allocation_method
    private_ip_address            = var.vm_private_ip
    public_ip_address_id          = var.create_public_ip == true ? azurerm_public_ip.vm_pip[0].id : null
  }

}

# create the virtual machine with given ssh-key
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_ssh_data[0].username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  tags = var.tags

  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_data
    content {
      username   = admin_ssh_key.value["username"]
      public_key = strcontains(admin_ssh_key.value["public_key"], ".pub") ? file(admin_ssh_key.value["public_key"]) : admin_ssh_key.value["public_key"]
    }
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
