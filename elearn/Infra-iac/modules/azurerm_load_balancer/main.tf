resource "azurerm_lb" "lb" {
  for_each            = var.lb
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_conf_name != null ? [1] : []
    content {
      name                 = each.value.frontend_ip_conf_name
      public_ip_address_id = each.value.frontend_ip_conf_name != null ? data.azurerm_public_ip.pip[each.key].id : null
    }
  }
}


