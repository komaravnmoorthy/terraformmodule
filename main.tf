# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "c1c99e83-d232-45df-af02-d5fe7ebd2e71"
  client_secret   = "3VB8Q~D24SC8vPkIt3nDfuU7P_CJcXJdhP4MLc.x"
  tenant_id       = "a4580296-9f34-4ce7-86f7-9dbf03aafbba"
  subscription_id = "2109209e-3579-4fcb-a302-b5f5e4020c84"
}

resource "azurerm_resource_group" "rg10" {
  name     = var.azurerm_resource_group-name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_virtual_network-name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.azurerm_resource_group-name
  depends_on = [azurerm_resource_group.rg10]
  
}

resource "azurerm_subnet" "snet" {
  name                 = var.azurerm_subnet
  resource_group_name  = var.azurerm_resource_group-name
  virtual_network_name = var.azurerm_virtual_network-name
  address_prefixes     = var.address_prefixes01
  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "snet1" {
  name                 = var.azurerm_subnet01
  resource_group_name  = var.azurerm_resource_group-name
  virtual_network_name = var.azurerm_virtual_network-name
  address_prefixes     = var.address_prefixes02
  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "snet2" {
  name                 = var.azurerm_subnet02
  resource_group_name  = var.azurerm_resource_group-name
  virtual_network_name = var.azurerm_virtual_network-name
  address_prefixes     = var.address_prefixes03
  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.azurerm_network_security_group-name
  location            = var.location
  resource_group_name = var.azurerm_resource_group-name

  security_rule {
    name                       = var.name
    priority                   = var.priority
    direction                  = var.direction
    access                     = var.access
    protocol                   = var.protocol
    source_port_range          = var.source_port_range
    destination_port_range     = var.destination_port_range
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = var.destination_address_prefix
  }
  depends_on = [azurerm_resource_group.rg10]
  
}