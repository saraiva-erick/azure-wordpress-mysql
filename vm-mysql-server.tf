# Create MySQL Server
resource "azurerm_mysql_server" "wordpress" {
  name                = "wordpress-mysql-server-vmss"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location

  administrator_login          = var.database_admin_login
  administrator_login_password = var.database_admin_password

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

  tags = local.commom_tags
}

# Create MySql DataBase
resource "azurerm_mysql_database" "wordpress" {
  name                = "wordpress-mysql-db"
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_mysql_server.wordpress.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Config MySQL Server Firewall Rule
resource "azurerm_mysql_firewall_rule" "wordpress" {
  name                = "wordpress-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_mysql_server.wordpress.name
  start_ip_address    = azurerm_public_ip.PublicIP_vmss_1.ip_address
  end_ip_address      = azurerm_public_ip.PublicIP_vmss_1.ip_address
  #start_ip_address    = "0.0.0.0"
  #end_ip_address      = "0.0.0.0"
}

data "azurerm_mysql_server" "wordpress" {
  name                = azurerm_mysql_server.wordpress.name
  resource_group_name = azurerm_resource_group.resource_group.name
}