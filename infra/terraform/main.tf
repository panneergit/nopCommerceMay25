resource "azurerm_resource_group" "this" {
  name = var.resource_group.name+"-${terraform.workspace}"
  location = var.resource_group.location
  tags = {
    Environment = terraform.workspace
    CreatedBy = "Terraform"
  }
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "workshop-aks-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location  
  dns_prefix          = "aks-${terraform.workspace}"

  default_node_pool {
    name       = var.aks_cluster_info.node_pool_name
    node_count = var.aks_cluster_info.node_count
    vm_size    = var.aks_cluster_info.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = terraform.workspace
    CreatedBy = "Terraform"
  }
}

resource "null_resource" "aks_get_connection" {
  triggers = {
    build_number = var.build_number
  }

  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.this.name} --name ${azurerm_kubernetes_cluster.this.name}"
  }

}
