resource "azurerm_public_ip" "public_ip_bastion" {
  name                = "public-ip-bastion"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = local.commom_tags
}

resource "azurerm_network_interface" "network_interface_bastion" {
  name                = "network-interface-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "public-ip-bastion"
    subnet_id                     = data.terraform_remote_state.vnet.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_bastion.id
  }

  tags = local.commom_tags
}

resource "azurerm_network_interface_security_group_association" "nisga" {
  network_interface_id      = azurerm_network_interface.network_interface_bastion.id
  network_security_group_id = data.terraform_remote_state.vnet.outputs.security_group_id
}

resource "azurerm_linux_virtual_machine" "vm_bastion" {
  name                  = "vm-bastion"
  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = var.location
  size                  = "Standard_B1Ls"
  admin_username        = "bastion"
  network_interface_ids = [azurerm_network_interface.network_interface_bastion.id]
  custom_data           = filebase64("scripts/script-apache.sh")
  #custom_data           = data.template_cloudinit_config.config_bastion.rendered
  #user_data_base64 = "${data.template_cloudinit_config.config_bastion.rendered}"

  admin_ssh_key {
    username   = "bastion"
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

  #depends_on = [azurerm_linux_virtual_machine_scale_set.vmss_1]

  tags = local.commom_tags
}

/* #script
data "template_file" "cloudconfig_bastion" {
  #template = file("./cloudconfig.conf")
  template = file("./script-apache.sh")
}

data "template_cloudinit_config" "config_bastion" {
  gzip          = true
  base64_encode = true

  part {
    #filename     = "./cloudconfig.conf"
    #content_type = "text/cloud-config"
    content_type = "text/x-shellscript"
    filename     = file("./script-apache.sh")
    content      = data.template_file.cloudconfig_bastion.rendered
  }
} */