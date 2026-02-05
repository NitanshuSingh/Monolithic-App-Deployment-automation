variable "rgs" {
    type = map(object({
      name = string
      location = string
    }))
    description = "rg values" 
}