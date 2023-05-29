#Declaração dos recursos para a 1ª VM Scale Set (vmss)
resource "azurerm_public_ip" "PublicIP_vmss_1" {
  name                = "PublicIPLB-vmss-1"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
  domain_name_label   = random_string.fqdn.result

  tags = local.commom_tags
}

resource "azurerm_lb" "load_balancer_vmss_1" {
  name                = "LoadBalancer-vmss-1"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress-Z1"
    public_ip_address_id = azurerm_public_ip.PublicIP_vmss_1.id
  }

  tags = local.commom_tags
}

resource "azurerm_lb_backend_address_pool" "backend_vmss_1" {
  loadbalancer_id = azurerm_lb.load_balancer_vmss_1.id
  name            = "backend-vmss-1"
}

resource "azurerm_lb_rule" "lb_rule_vmss_1" {
  loadbalancer_id                = azurerm_lb.load_balancer_vmss_1.id
  name                           = "LBRule-vmss-1"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress-Z1"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_vmss_1.id]
}


#Declaração dos recursos para a 2ª VM Scale Set (vmss)
resource "azurerm_public_ip" "PublicIP_vmss_2" {
  name                = "PublicIPLB-vmss-2"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["3"]
  domain_name_label   = random_string.fqdn_2.result

  tags = local.commom_tags
}

resource "azurerm_lb" "load_balancer_vmss_2" {
  name                = "LoadBalancer-vmss-2"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress-Z2"
    public_ip_address_id = azurerm_public_ip.PublicIP_vmss_2.id
  }

  tags = local.commom_tags
}

resource "azurerm_lb_backend_address_pool" "backend_vmss_2" {
  loadbalancer_id = azurerm_lb.load_balancer_vmss_2.id
  name            = "backend-vmss-2"
}

resource "azurerm_lb_rule" "lb_rule_vmss_2" {
  loadbalancer_id                = azurerm_lb.load_balancer_vmss_2.id
  name                           = "LBRule-vmss-2"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress-Z2"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_vmss_2.id]
}