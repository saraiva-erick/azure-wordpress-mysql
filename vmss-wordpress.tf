
#Declaração da 1ª VM Scale Set (vmss)
resource "azurerm_linux_virtual_machine_scale_set" "vmss_1" {
  name                = "VMSS-1"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  sku                 = "Standard_B1ls"
  instances           = 2
  zones               = ["1"]
  admin_username      = "terraform"
  custom_data         = data.template_cloudinit_config.config.rendered

  admin_ssh_key {
    username   = "terraform"
    public_key = file("./azure-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  network_interface {
    name    = "network_interface-vmss-1"
    primary = true

    ip_configuration {
      name      = "ip-config-vmss-1"
      primary   = true
      subnet_id = data.terraform_remote_state.vnet.outputs.subnet_id

      # Configurando o balanceador de carga
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_vmss_1.id]
    }
  }

  tags = local.commom_tags

  depends_on = [azurerm_mysql_server.wordpress]
}

#script
data "template_file" "cloudconfig" {
  template = file("./cloudconfig.conf")
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "./cloudconfig.conf"
    content_type = "text/cloud-config"
    content      = data.template_file.cloudconfig.rendered
  }
}

/* 
########################################### 2º VMSS
#Declaração da 2ª VM Scale Set (vmss)
resource "azurerm_linux_virtual_machine_scale_set" "vmss_2" {
  name                = "VMSS-2"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  sku                 = "Standard_B1ls"
  instances           = 2
  zones               = ["3"]
  admin_username      = "terraform"
  custom_data         = data.template_cloudinit_config.config_2.rendered

  admin_ssh_key {
    username   = "terraform"
    public_key = file("./azure-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  network_interface {
    name    = "network_interface-vmss-2"
    primary = true

    ip_configuration {
      name      = "ip-config-vmss-2"
      primary   = true
      subnet_id = data.terraform_remote_state.vnet.outputs.subnet_id

      # Configurando o balanceador de carga
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_vmss_2.id]
    }
  }

  tags = local.commom_tags

  depends_on = [azurerm_mysql_server.wordpress]
}

#script
data "template_file" "cloudconfig_2" {
  template = file("./cloudconfig.conf")
}

data "template_cloudinit_config" "config_2" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "./cloudconfig.conf"
    content_type = "text/cloud-config"
    content      = data.template_file.cloudconfig_2.rendered
  }
} */