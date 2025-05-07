terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "nop-jenkins-server_group"
    storage_account_name = "nopterraformbackend"
    container_name = "state"
    key = "workshop.tfstate"
  }
}

provider "azurerm" {
  features {
    
  }
}