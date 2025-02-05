terraform {
  cloud {
    organization = "Fabo011"
    workspaces {
      name = "terraform-test"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "global_location" {
  default = "Germany West Central"
}

resource "azurerm_resource_group" "global" {
  name     = "global-resource-group"
  location = var.global_location
}

module "app_service" {
  source              = "./app-service"
  resource_group_name = azurerm_resource_group.global.name
  location            = var.global_location
}
