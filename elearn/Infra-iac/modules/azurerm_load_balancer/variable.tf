variable "lb" {
  type = map(object({
    name = string
    location = string
    resource_group_name = string
    frontend_ip_conf_name = optional(string)
    pip_name = optional(string)
  }))
}