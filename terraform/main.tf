resource "azurerm_resource_group" "func_app" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "account" {
  
    # Generate a new id each time we switch to a new Azure Resource Group
    keepers = {
      # Generate a new ID only when a new resource group is defined
      rg_id = azurerm_resource_group.func_app.name
    }
    

  byte_length = 8
}


resource "random_id" "function_name" {

  keepers = {
      # Generate a new ID only when a new resource group is defined
      resource_group = azurerm_resource_group.func_app.name
    }

  byte_length = 8
}

resource "azurerm_storage_account" "storage_account" {
  name                     = random_id.account.hex
  resource_group_name      = azurerm_resource_group.func_app.name
  location                 = azurerm_resource_group.func_app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}