resource "azurerm_resource_group" "BhushanRG" {
  name     = var.resource_group
  location = var.location

}
resource "azurerm_virtual_network" "BhushanVNet" {
  name                = var.azurerm_virtual_network
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group
  depends_on = [
    azurerm_resource_group.BhushanRG
  ]
}
resource "azurerm_subnet" "PublicSubnet" {
  name                 = var.azurerm_subnet
  resource_group_name  = azurerm_resource_group.BhushanRG.name
  virtual_network_name = azurerm_virtual_network.BhushanVNet.name
  address_prefixes     = var.address_prefixes
  depends_on = [
    azurerm_resource_group.BhushanRG,
    azurerm_virtual_network.BhushanVNet
  ]


}
resource "azurerm_network_interface" "ProdNIC" {
  name                = var.azurerm_network_interface
  location            = azurerm_resource_group.BhushanRG.location
  resource_group_name = azurerm_resource_group.BhushanRG.name

  ip_configuration {
    name                          = var.azurerm_subnet
    subnet_id                     = azurerm_subnet.PublicSubnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

}
resource "azurerm_linux_virtual_machine" "LinuxOS" {
  name                = var.azurerm_linux_virtual_machine
  resource_group_name = azurerm_resource_group.BhushanRG.name
  location            = azurerm_resource_group.BhushanRG.location
  size                = "Standard_F2"
  admin_username      = "linuxadmin"
  network_interface_ids = [
    azurerm_network_interface.ProdNIC.id,
  ]

  admin_ssh_key {
    username   = "linuxadmin"
    public_key = file("~/.ssh/id_rsa.pub")

  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
