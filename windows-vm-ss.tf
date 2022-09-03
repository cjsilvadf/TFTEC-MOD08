resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                 = "scalevmtemplate"
  location             = azurerm_resource_group.network-rg.location
  resource_group_name  = azurerm_resource_group.network-rg.name
  upgrade_mode         = "Automatic"
  sku                  = var.windows-vm-size
  instances            = "2"
  computer_name_prefix = var.windows-vm-hostname
  admin_username       = var.windows-admin-username
  admin_password       = var.windows-admin-password
  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }
  network_interface {
    name    = "nic-vmss"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.vm-subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
    }
  }
  tags = {
    application = var.app_name
    environment = var.environment
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }
  scale_in_policy = var.scale_in_policy
  depends_on = [
    azurerm_lb_rule.lb-rule
  ]


}
resource "azurerm_virtual_machine_scale_set_extension" "vm-ss-ext" {
  name                         = "vm-ss-ext"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.vmss.id
  publisher                    = "Microsoft.Compute"
  type                         = "CustomScriptExtension"
  type_handler_version         = "1.8"
  auto_upgrade_minor_version   = true
  settings                     = <<SETTINGS
    {      
      "commandToExecute": "powershell -encodedCommand ${textencodebase64(file("script.ps1"), "UTF-16LE")}"
    }
SETTINGS

}
