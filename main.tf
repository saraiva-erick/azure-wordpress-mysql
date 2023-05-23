terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      #version = "3.55.0"
      version = ">= 2.56"
    }
  }

  backend "azurerm" {
    resource_group_name  = "storage_account_resource_group"
    storage_account_name = "saesaraiva"
    container_name       = "remotestate"
    key                  = "azure-vm/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "storage_account_resource_group"
    storage_account_name = "saesaraiva"
    container_name       = "remotestate"
    key                  = "azure-vnet/terraform.tfstate"
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = "infnet-wordpress"
  location = var.location

  tags = local.commom_tags
}

resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}

resource "random_string" "fqdn_2" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}