provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "The Azure client ID"
  type        = string
}

variable "client_secret" {
  description = "The Azure client secret"
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
}

resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "Norway East"
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
  name                = "hardingenexam"
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




