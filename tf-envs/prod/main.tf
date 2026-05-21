provider "azurerm" {
  features {} 
}

module "vnet" {
  source              = "../../modules/virtual-network"
  count               = var.environment == "prod" ? 1 : 0
  vnet_name           = "prod-vnet"
  location            = var.location
  resource_group_name = "prod-rg"
  address_space       = ["10.0.0.0/16"]
  subnet_names        = ["subnet1", "subnet2"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  tags                = { environment = "prod" }
}
resource "azurerm_network_interface" "nic" {
  name                = "prod-nic"
  location            = var.location
  resource_group_name = "prod-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = element(module.vnet, 0).subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ module.vnet ]
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "prod-vm"
  resource_group_name = "prod-rg"
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "azureuser@123"
  network_interface_ids = [azurerm_network_interface.nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  depends_on = [ module.vnet, azurerm_network_interface.nic ]
}
