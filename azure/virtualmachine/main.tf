module "network_setup" {
  count                       = var.create_network == true ? 1 : 0
  source                      = "./../network"
  resource_group_name         = var.resource_group_name
  resource_group_location     = var.resource_group_location
  vnet_name                   = "${var.vm_name}-vnet"
  vnet_address_space          = var.vnet_address_space
  vm_subnet_name              = "${var.vm_name}-subnet"
  vm_subnet_address_prefix    = var.vm_subnet_address_prefix
  network_security_group_name = "${var.vm_name}-nsg"
  nsgrules                    = var.nsgrules
  tags                        = var.tags
}


module "ssh_setup" {
  count                           = var.create_ssh_key == true ? 1 : 0
  create_keyvault                 = var.create_keyvault
  ssh_key_name                    = "${var.vm_name}-sshkey"
  keyvault_access_group_object_id = var.keyvault_access_group_object_id
  resource_group_location         = var.resource_group_location
  resource_group_name             = var.resource_group_name
  resource_group_id               = var.resource_group_id
  tenant_id                       = var.tenant_id
  key_permissions                 = var.keyvault_key_permissions
  secret_permissions              = var.keyvault_secret_permissions
  storage_permissions             = var.keyvault_storage_permissions
  certificate_permissions         = var.keyvault_certificate_permissions
  source                          = "./../sshkey"


}

resource "azurerm_public_ip" "vm_pip" {
  count               = var.enable_public_ip == true ? 1 : 0
  name                = "${var.vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = var.pubip_allocation_method
  sku                 = var.pubip_sku
  tags                = var.tags
}

# create a network interface with a static ip
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags                = var.tags

  ip_configuration {
    name                          = "${var.vm_name}-nic-config"
    subnet_id                     = module.network_setup[0].vm_subnet_id
    private_ip_address_allocation = var.privateip_allocation_method
    private_ip_address            = var.vm_private_ip
    public_ip_address_id          = azurerm_public_ip.vm_pip[0].id
  }

}

# create the virtual machine with given ssh-key
resource "azurerm_linux_virtual_machine" "virtualmachine_provided_key" {
  count               = var.create_ssh_key == false ? 1 : 0
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

resource "azurerm_linux_virtual_machine" "virtualmachine_genkey" {
  count               = var.create_ssh_key == true ? 1 : 0
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
    public_key = module.ssh_setup[0].public_key
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
