variable "location" {
  description = "Varável que india onde os recursos serão criados"
  type        = string
  default     = "Brazil South"
}

variable "database_admin_login" {
  default = "wordpress"
}

variable "database_admin_password" {
  default = "w0rdpr3ss@p4ss"
}

#variable "cloud_script" {
#  description = "Define your VM Scale set and the script you want to add as a custom script."
#  default = {
#    vmss_name                = azurerm_linux_virtual_machine_scale_set.vmss_1.name
#    vmss_resource_group_name = azurerm_resource_group.resource_group.name
#    filename                 = file("./cloudconfig.conf")
#  }
#}