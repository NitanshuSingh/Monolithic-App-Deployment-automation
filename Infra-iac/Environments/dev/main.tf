module "rg" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_vnet_subnet"
  vnet       = var.vnet
  subnet     = var.subnet
}

module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  pip        = var.pip
}

module "nic" {
  depends_on = [module.vnet]
  source     = "../../modules/azurerm_network_interface"
  nic        = var.nic
}

module "vm" {
  depends_on = [module.nic, module.pip, module.vnet, module.rg]
  source     = "../../modules/azurerm_linux_virtual_machine"
  vm         = var.vm
}

module "nsg" {
  depends_on    = [module.vnet]
  source        = "../../modules/azurerm_network_security_group"
  nsg           = var.nsg
  security_rule = var.security_rule
}

module "lb" {
  source = "../../modules/azurerm_load_balancer"
  lb = var.lb
  depends_on = [ module.rg, module.pip ]
}