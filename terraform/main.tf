terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.3.2"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "<YOUR_SUBSCRIPTION_ID>"
}

provider "random" {
}

resource "azurerm_resource_group" "kube-rg" {
  name     = "kube-rg"
  location = "east us"
}

resource "azurerm_kubernetes_cluster" "kube-cluster" {
  name                = "kube-cluster-aks1"
  location            = azurerm_resource_group.kube-rg.location
  resource_group_name = azurerm_resource_group.kube-rg.name
  dns_prefix          = "kubeclusteraks1"

  default_node_pool {
    name       = "nodepool"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}