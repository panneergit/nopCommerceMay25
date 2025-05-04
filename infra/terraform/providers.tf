terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraform-rg"
    storage_account_name = "terraform-backend"
    container_name = "state"
    key = "workshop.tfstate"
  }
}

provider "azurerm" {
  features {
    
  }
}