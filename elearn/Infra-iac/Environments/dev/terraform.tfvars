rgs = {
  rg1 = {
    name     = "app01-dev-rg"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name                = "app01-dev-vnet"
    location            = "centralindia"
    resource_group_name = "app01-dev-rg"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet = {
  subnet1 = {
    name             = "ui-subnet"
    address_prefixes = ["10.0.0.0/24"]
  }
  subnet2 = {
    name             = "app-subnet"
    address_prefixes = ["10.0.1.0/24"]
  }
}

pip = {
  pip1 = {
    name                = "ui-pip"
    location            = "centralindia"
    resource_group_name = "app01-dev-rg"
  }
  pip2 = {
    name                = "app-pip"
    location            = "centralindia"
    resource_group_name = "app01-dev-rg"
  }
  pip3 = {
    name                = "lb-pip"
    location            = "centralindia"
    resource_group_name = "app01-dev-rg"
  }
}


nic = {
  nic1 = {
    name                  = "ui-nic"
    location              = "centralindia"
    resource_group_name   = "app01-dev-rg"
    ip_configuration_name = "ui-ip"
    virtual_network_name  = "app01-dev-vnet"
    subnet_name           = "ui-subnet"
    pip_name              = "ui-pip"
  }
  nic2 = {
    name                  = "app-nic"
    location              = "centralindia"
    resource_group_name   = "app01-dev-rg"
    ip_configuration_name = "app-ip"
    virtual_network_name  = "app01-dev-vnet"
    subnet_name           = "app-subnet"
    pip_name              = "app-pip"
  }
}

vm = {
  vm1 = {
    name                = "ui-app01-dev-vm"
    resource_group_name = "app01-dev-rg"
    location            = "centralindia"
    size                = "Standard_D2ls_v5"
    admin_username      = "adminuser"
    admin_password      = "User@123456"
    nic_name            = "ui-nic"
  }
  vm2 = {
    name                = "app-app01-dev-vm"
    resource_group_name = "app01-dev-rg"
    location            = "centralindia"
    size                = "Standard_D2ls_v5"
    admin_username      = "adminuser"
    admin_password      = "User@123456"
    nic_name            = "app-nic"
  }
}

nsg = {
  nsg1 = {
    name                 = "ui-subnet-nsg"
    resource_group_name  = "app01-dev-rg"
    location             = "centralindia"
    subnet_name          = "ui-subnet"
    virtual_network_name = "app01-dev-vnet"
  }
  nsg2 = {
    name                 = "app-subnet-nsg"
    resource_group_name  = "app01-dev-rg"
    location             = "centralindia"
    subnet_name          = "app-subnet"
    virtual_network_name = "app01-dev-vnet"
  }
}

security_rule = {
  rule1 = {
    rule_name                  = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

lb = {
  lb1 = {
    name                = "lb-internal-app01"
    location            = "centralindia"
    resource_group_name = "app01-dev-rg"
  }
  lb2 = {
    name                  = "lb-ext-app01"
    location              = "centralindia"
    resource_group_name   = "app01-dev-rg"
    frontend_ip_conf_name = "lb-pip"
    pip_name              = "lb-pip"
  }
}

mysql = {
  mysql1 = {
    mysql_server_name   = "elearn-db-server"
    location            = "canadacentral"
    resource_group_name = "app01-dev-rg"
    mysql_db_name       = "elearn-db"
  }
}
