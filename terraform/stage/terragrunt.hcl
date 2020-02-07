remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "storage-resource-group"
        storage_account_name = "terraformstate5844"
        container_name = "tfstate"
    }
}


inputs = {
  location = "northeurope"
  resource_group_name = "functions"
}