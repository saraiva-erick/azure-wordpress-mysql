output "application_public_address_vmss1_zone1" {
  value = azurerm_public_ip.PublicIP_vmss_1.fqdn
}

output "application_public_address_vmss1_zone3" {
  value = azurerm_public_ip.PublicIP_vmss_2.fqdn
}

output "azure_mysql_server" {
  value = azurerm_mysql_firewall_rule.wordpress.server_name
}

output "bastion_public_address" {
  #value = azurerm_public_ip.wordpress.fqdn
  value = azurerm_linux_virtual_machine.vm_bastion.public_ip_address
}

/*
output "private_ip_vmss_1" {
  #value = azurerm_linux_virtual_machine_scale_set.vmss_1.network_profile_configuration[0].ip_configurations[0].private_ip_address
  #value = azurerm_linux_virtual_machine_scale_set.vmss_1.virtual_machine_instances[*].private_ip_address
  #value = azurerm_linux_virtual_machine_scale_set.vmss_1.virtual_machine[*].network_interface_ids[*].private_ip_address
  value = azurerm_linux_virtual_machine_scale_set.vmss_1.network_interface_ids[*].ip_configuration.0.private_ip_address
}
*/