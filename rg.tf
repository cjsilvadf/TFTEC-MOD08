resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false

}

# Create a resource group for network
resource "azurerm_resource_group" "network-rg" {
  name     = "RG-MOD08"
  location = var.location_eastus
  tags = {
    application = var.app_name
    environment = var.environment
  }
}