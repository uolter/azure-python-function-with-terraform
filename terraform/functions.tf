data "azurerm_storage_account_sas" "sas" {
    connection_string = "${azurerm_storage_account.storage_account.primary_connection_string}"
    https_only = true
    start = "2019-01-01"
    expiry = "2021-12-31"
    resource_types {
        object = true
        container = false
        service = false
    }
    services {
        blob = true
        queue = false
        table = false
        file = false
    }
    permissions {
        read = true
        write = false
        delete = false
        list = false
        add = false
        create = false
        update = false
        process = false
    }
}


resource "azurerm_storage_container" "deployments" {
    name = "function-releases"
    storage_account_name = azurerm_storage_account.storage_account.name
    container_access_type = "private"
}


resource "azurerm_storage_blob" "appcode" {
    name = "functionapp.zip"
    storage_account_name = azurerm_storage_account.storage_account.name
    storage_container_name = azurerm_storage_container.deployments.name
    type = "block"
    source = "../MyFunctionProj/functionapp.zip"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "azure-functions-service-plan"
  location            = azurerm_resource_group.func_app.location
  resource_group_name = azurerm_resource_group.func_app.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_application_insights" "application_insights" {
  name                = "application-insights"
  location            = azurerm_resource_group.func_app.location
  resource_group_name = azurerm_resource_group.func_app.name
  application_type    = "Web"
}


resource "azurerm_function_app" "my_function" {
  name                      = "function-${random_id.function_name.hex}"
  location                  = azurerm_resource_group.func_app.location
  resource_group_name       = azurerm_resource_group.func_app.name
  app_service_plan_id       = azurerm_app_service_plan.plan.id
  storage_connection_string = azurerm_storage_account.storage_account.primary_connection_string
  version = "~2"

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

    https_only = true
    FUNCTIONS_WORKER_RUNTIME = "python"
    FUNCTION_APP_EDIT_MODE = "readonly"
    HASH = "${base64encode(filesha256("../MyFunctionProj/functionapp.zip"))}"
    WEBSITE_RUN_FROM_PACKAGE = "https://${azurerm_storage_account.storage_account.name}.blob.core.windows.net/${azurerm_storage_container.deployments.name}/${azurerm_storage_blob.appcode.name}${data.azurerm_storage_account_sas.sas.sas}"
  }
}

