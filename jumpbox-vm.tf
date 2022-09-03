resource "azurerm_windows_virtual_machine" "jumpbox" {
  name                  = "jumpbox"
  location              = var.location_eastus
  resource_group_name   = azurerm_resource_group.network-rg.name
  network_interface_ids = [azurerm_network_interface.jumpbox.id]
  size                  = "Standard_B2s"
  admin_username        = var.windows-admin-username
  admin_password        = var.windows-admin-password

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    name                 = "jumpbox-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  tags = var.tags
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown-jumpbox" {
  virtual_machine_id = azurerm_windows_virtual_machine.jumpbox.id
  location           = azurerm_resource_group.network-rg.location
  enabled            = true
  daily_recurrence_time = "1830"
  timezone              = "E. South America Standard Time"

  notification_settings {
    enabled         = true
    time_in_minutes = "15"
    email = var.notification_email
  }
}