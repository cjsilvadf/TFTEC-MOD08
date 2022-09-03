# Create Network Security Group and rule
resource "azurerm_network_security_group" "ResNGS" {
  name                = var.nsg_name
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  depends_on = [
    azurerm_subnet.vm-subnet
  ]
  security_rule {
    name                   = "HTTP"
    priority               = 350
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "80"
    source_address_prefix  = "*"
    //destination_address_prefixes = ["10.8.1.0/24"]
    destination_address_prefix = var.vm-subnet-cidr
  }
  security_rule {
    name                       = "RDP"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    //destination_address_prefixes = azurerm_subnet.vm-subnet.id
  }
  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.vm-subnet.id
  network_security_group_id = azurerm_network_security_group.ResNGS.id
}