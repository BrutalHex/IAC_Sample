# Create a resource group
resource "azurerm_resource_group" "dehn" {
  name     = "dehn${var.environment}"
  location = var.location
  tags = {
    environment = var.environment
  }

}



resource "azurerm_service_plan" "dehn" {
  name                = "dehn${var.environment}"
  location            = azurerm_resource_group.dehn.location
  resource_group_name = azurerm_resource_group.dehn.name
  os_type             = "Linux"
  sku_name            = "Y1"
  tags = {
    environment = var.environment
  }
}

