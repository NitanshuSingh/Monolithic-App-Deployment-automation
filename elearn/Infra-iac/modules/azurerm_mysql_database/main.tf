resource "azurerm_mysql_flexible_server" "mysql_server" {
    for_each = var.mysql
  name                   = each.value.mysql_server_name
  resource_group_name    = each.value.resource_group_name
  location               = each.value.location
  administrator_login    = "mysqladmin"
  administrator_password = "H@Sh1CoR3!"
  sku_name               = "B_Standard_B1ms"
}

resource "azurerm_mysql_flexible_database" "mysql_db" {
    for_each = var.mysql
  name                = each.value.mysql_db_name
  resource_group_name = azurerm_mysql_flexible_server.mysql_server[each.key].resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql_server[each.key].name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}