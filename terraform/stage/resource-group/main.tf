terraform {
  backend "azurerm" {}
}


resource "azurerm_resource_group" "func_app" {
  name     = var.resource_group_name
  location = var.location
}