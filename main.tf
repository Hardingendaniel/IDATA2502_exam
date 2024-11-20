provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "agentpool"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity { # Use Managed Identity
    type = "SystemAssigned"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "myregistry"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
}

resource "azurerm_container_registry_webhook" "webhook" {
  name                = "webhook"
  registry_name       = azurerm_container_registry.acr.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_uri         = "https://example.com/webhook-handler" # Replace with your endpoint
  actions             = ["push"] # Add the actions you need
  status              = "enabled" 
}




