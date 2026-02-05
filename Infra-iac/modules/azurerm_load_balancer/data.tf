data "azurerm_public_ip" "pip" {
  for_each = {
    for k, v in var.lb :
    k => v
    if v.pip_name != null
  }
  name = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}