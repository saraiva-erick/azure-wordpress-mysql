/* resource "azurerm_service_plan" "wordpress_serviceplan" {
  name                = "wordpress-serviceplan"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "wordpress_webapp" {
  name                = "wordpress-webapp"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.wordpress_serviceplan.id

  site_config {
    #dotnet_framework_version = "v4.0"
    #scm_type                 = ""
    #scm_type    = "GitHub"
    #default_documents        = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iistart.htm", "default.aspx", "index.php", "hostingstart.html"]

    application_stack {
      dotnet_version = "v5.0"
      #docker_image = "https://github.com/docker-library/wordpress/blob/6fa05d9ba94e7cb48a53ff90878cc6fc777f7986/latest/php8.2/apache/Dockerfile"
      docker_image = "https://github.com/azureappserviceoss/wordpress-azure"
    }
  }

  connection_string {
    name  = "defaultConnection"
    type  = "MySQL"
    value = "Database=wordpress;Data Source=wordpress-mysql-server-vmss.mysql.database.azure.com;User Id=wordpress;Password=w0rdpr3ss@p4ss"
  }

  depends_on = [azurerm_mysql_server.wordpress]
} */

/* resource "azurerm_app_service" "wordpress_app" {
  name                = "wordpress-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_service_plan.wordpress_serviceplan.id

  source_control {
    repo_url = "https://github.com/azureappserviceoss/wordpress-azure"
    branch   = "master"
  }

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = ""
    #scm_type    = "ExternalGit"
    #default_documents        = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iistart.htm", "default.aspx", "index.php", "hostingstart.html"]
  }

  connection_string {
    name  = "defaultConnection"
    type  = "MySQL"
    value = "Database=wordpress;Data Source=wordpress-mysql-server-vmss.mysql.database.azure.com;User Id=wordpress;Password=w0rdpr3ss@p4ss"
  }

  depends_on = [azurerm_mysql_server.wordpress]
} */