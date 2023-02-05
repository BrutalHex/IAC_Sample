data "archive_file" "file-function-app" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "../src/app.zip"
}
resource "azurerm_storage_blob" "code" {
  name                   = "${filesha256(data.archive_file.file-function-app.output_path)}${var.environment}.zip"
  storage_account_name   = azurerm_storage_account.dehn.name
  storage_container_name = azurerm_storage_container.dehn-statics.name
  type                   = "Block"
  source                 = data.archive_file.file-function-app.output_path

}
data "azurerm_storage_account_blob_container_sas" "dehn" {
  connection_string = azurerm_storage_account.dehn.primary_connection_string
  container_name    = azurerm_storage_container.dehn-statics.name

  start  = "2021-01-01T00:00:00Z"
  expiry = "2029-01-01T00:00:00Z"

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }

}

resource "azurerm_function_app" "dehn" {
  name                       = "dehn-mohammad${var.environment}"
  location                   = azurerm_resource_group.dehn.location
  resource_group_name        = azurerm_resource_group.dehn.name
  app_service_plan_id        = azurerm_service_plan.dehn.id
  storage_account_name       = azurerm_storage_account.dehn.name
  storage_account_access_key = azurerm_storage_account.dehn.primary_access_key

  os_type = "linux"
  version = "~4"

  app_settings = {

    FUNCTIONS_WORKER_RUNTIME            = "node"
    AZURE_STORAGE_CONTAINER             = azurerm_storage_container.dehn-statics.name
    AZURE_STORAGE_BLOB                  = azurerm_storage_blob.hello-world.name
    AZURE_STORAGE_ACCOUNT               = azurerm_storage_account.dehn.name
    AZURE_STORAGE_ACCESS_KEY            = azurerm_storage_account.dehn.primary_access_key
    WEBSITE_RUN_FROM_PACKAGE            = "https://${azurerm_storage_account.dehn.name}.blob.core.windows.net/${azurerm_storage_container.dehn-statics.name}/${azurerm_storage_blob.code.name}${data.azurerm_storage_account_blob_container_sas.dehn.sas}"
    AzureWebJobsDisableHomepage         = true
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = true
    SELECTED_ENV                        = "${var.environment}"
  }

  site_config {
    linux_fx_version          = "node|18"
    use_32_bit_worker_process = false
  }
  tags = {
    environment = var.environment
  }

}
