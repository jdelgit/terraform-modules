output "client_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}

output "kublet_object_id" {
  value = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.cluster.id
}

output "kublet_api_endpoint" {
  value = azurerm_kubernetes_cluster.cluster.fqdn
}
