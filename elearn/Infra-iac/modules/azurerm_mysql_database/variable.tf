variable "mysql" {
  type = map(object({
    mysql_server_name = string
    location = string
    resource_group_name = string
    mysql_db_name = string
  }))
}