output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kube-cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kube-cluster.kube_config_raw

  sensitive = true
}

output "kube_cluster_name" {
  value = azurerm_kubernetes_cluster.kube-cluster.name
}

output "kube_cluster_id" {
  value = azurerm_kubernetes_cluster.kube-cluster.id
}

output "kube_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.kube-cluster.fqdn
}

output "kube_cluster_location" {
  value = azurerm_kubernetes_cluster.kube-cluster.location
}

output "kube_cluster_resource_group_name" {
  value = azurerm_kubernetes_cluster.kube-cluster.resource_group_name
}

output "kube_cluster_node_resource_group" {
  value = azurerm_kubernetes_cluster.kube-cluster.node_resource_group
}

output "kube_cluster_identity" {
  value = azurerm_kubernetes_cluster.kube-cluster.identity
}

output "kube_cluster_identity_principal_id" {
  value = azurerm_kubernetes_cluster.kube-cluster.identity.0.principal_id
}

output "kube_cluster_identity_tenant_id" {
  value = azurerm_kubernetes_cluster.kube-cluster.identity.0.tenant_id
}

output "kube_cluster_identity_type" {
  value = azurerm_kubernetes_cluster.kube-cluster.identity.0.type
}

output "kube_cluster_default_node_pool" {
  value = azurerm_kubernetes_cluster.kube-cluster.default_node_pool
}
