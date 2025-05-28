output "kube_config" {
  value     = azurerm_kubernetes_cluster.kube-cluster.kube_config_raw
  sensitive = true
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.kube-cluster.name
}

output "aks_cluster_fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = azurerm_kubernetes_cluster.kube-cluster.fqdn
}

output "resource_group_name" {
  description = "The name of the resource group containing the AKS cluster."
  value       = azurerm_resource_group.kube-rg.name
}

output "default_node_pool_name" {
  description = "The name of the default node pool in the AKS cluster."
  value       = azurerm_kubernetes_cluster.kube-cluster.default_node_pool[0].name
}
