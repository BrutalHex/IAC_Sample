
resource "azurerm_storage_account" "dehn" {
  name                     = "dehn${var.environment}"
  resource_group_name      = azurerm_resource_group.dehn.name
  location                 = azurerm_resource_group.dehn.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  tags = {
    environment = var.environment
  }
}
resource "azurerm_storage_container" "dehn-statics" {
  name                  = "dehn-statics${var.environment}"
  storage_account_name  = azurerm_storage_account.dehn.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "hello-world" {
  name                   = "hello-world${var.environment}.txt"
  storage_account_name   = azurerm_storage_account.dehn.name
  storage_container_name = azurerm_storage_container.dehn-statics.name
  type                   = "Block"
  source                 = "${path.module}/artifacts/hello-world.txt"
  content_md5            = filemd5("${path.module}/artifacts/hello-world.txt")

}