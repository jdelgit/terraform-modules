resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.acr_sku
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "acr" {
  count               = var.create_private_dns_zone == true ? 1 : 0
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
}


resource "azurerm_private_endpoint" "pe_acr" {
  count               = var.create_private_endpoint == true ? 1 : 0
  name                = format("pe-%s", var.acr_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_dns_zone_group {
    name                 = "${var.acr_name}privatednszonegroup"
    private_dns_zone_ids = var.create_private_dns_zone == true ? [azurerm_private_dns_zone.acr[0].id] : [var.private_dns_zone_id]
  }

  private_service_connection {
    name                           = format("pse-%s", var.acr_name)
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}


# Link ACR to AKS
resource "azurerm_role_assignment" "cluster-acrpull" {
  count                            = var.link_aks_cluster == true ? 1 : 0
  principal_id                     = var.kublet_object_id
  scope                            = var.aks_cluster_id
  role_definition_name             = "AcrPull"
  skip_service_principal_aad_check = true
}
