variable "nsg" {
  type = map(object({
    name = string
    location = string
    resource_group_name = string
        subnet_name = string
        virtual_network_name = string
  }))
}

variable "security_rule" {
    type = map(object({
    rule_name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}