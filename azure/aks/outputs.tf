output "kube_config" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}

output "kublet_object_id" {
  value = azurerm_kubernetes_cluster.cluster.kubelet_identity
}

output "node_pool_resource_group" {
  value = azurerm_kubernetes_cluster.cluster.node_resource_group
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.cluster.id
}

output "kublet_api_endpoint" {
  value = azurerm_kubernetes_cluster.cluster.fqdn
}

output "secrets_provider_secret_identity" {
  value = azurerm_kubernetes_cluster.cluster.key_vault_secrets_provider
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.cluster.oidc_issuer_url
}