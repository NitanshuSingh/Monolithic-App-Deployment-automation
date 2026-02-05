variable "nic" {
    type = map(object({
      name = string
      location = string
      resource_group_name = string
      ip_configuration_name = string
      virtual_network_name = string
      subnet_name = optional(string)
      pip_name = string
    }))
}