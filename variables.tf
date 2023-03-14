variable "resource_group" {
  description = "this is bhushan RG"
  type        = string
}
variable "location" {
  type = string

}
variable "azurerm_virtual_network" {
  description = "this is Prod Vnet"
  type        = string
}
variable "address_space" {
  description = "Vnet address space for Pord"
  type        = list(string)
}
variable "azurerm_subnet" {
  description = "subnet space name"
  type        = string

}
variable "address_prefixes" {
  description = "Virtual Network CIDR range for all the environmetns except Dev"
  type        = list(string)

}
variable "azurerm_network_interface" {
  type = string

}
variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"

}
variable "azurerm_linux_virtual_machine" {
  type = string

}
variable "size" {
  type = list(string)

}
