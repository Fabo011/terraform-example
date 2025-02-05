variable "resource_group_name" {}
variable "location" {}


resource "azurerm_service_plan" "app-test-service-plan" {
  name                = "app-test-service-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "test-app" {
  name                = "test-app-ffftttteuuooownndkidiiks"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.app-test-service-plan.id

  site_config {
    application_stack {
      node_version = "20-lts"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

output "app_service_url" {
  value = azurerm_linux_web_app.test-app.default_hostname
}
