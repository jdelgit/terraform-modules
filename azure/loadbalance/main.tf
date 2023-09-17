resource "azurerm_public_ip" "loadbalancer-pip" {
  name                = var.loadbalancer_public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.loadbalancer_public_ip_method
  tags                = var.tags
}

resource "azurerm_public_ip" "http-pip" {
  name                = var.http_public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.http_public_ip_method
  tags                = var.tags
}

resource "azurerm_lb" "loadbalancer" {
  name                = var.loadbalancer_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.loadbalancer-pip.id
  }

  frontend_ip_configuration {
    name                 = "PublicIPAddresshttp"
    public_ip_address_id = azurerm_public_ip.http-pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = var.loadbalancer_backend_pool_name
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_address_pool_association" {
  network_interface_id    = var.vm_nic_interface_id
  ip_configuration_name   = var.vm_nic_config
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

# create probe for health check
resource "azurerm_lb_probe" "http-port80-running-probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "http-port80-running-probe"
  port                = 80
}

resource "azurerm_lb_rule" "http-port80-lbrule" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "http-port80-LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddresshttp"
  load_distribution              = "SourceIP"
  probe_id                       = azurerm_lb_probe.http-port80-running-probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

# create probe for health check
resource "azurerm_lb_probe" "http-port443-running-probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "http-port443-running-probe"
  port                = 443
}

resource "azurerm_lb_rule" "http-port443-lbrule" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "http-port443-LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "PublicIPAddresshttp"
  load_distribution              = "SourceIP"
  probe_id                       = azurerm_lb_probe.http-port443-running-probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb_backend_pool.id
}
