terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "api-rg-pro"
  location = "West Europe"
}


resource "azurerm_dns_zone" "example-public" {
  name                = "bhosdike.tk"
  resource_group_name = azurerm_resource_group.example.name

  depends_on = [
    azurerm_resource_group.example
  ]
}



output "dns_server" {
    value = azurerm_dns_zone.example-public.name_servers 
}

resource "azurerm_dns_a_record" "dnsrecord" {
  name                = "www"
  zone_name           = azurerm_dns_zone.example-public.name
  resource_group_name = azurerm_resource_group.example.name
  ttl                 = 360
  records             = [azurerm_public_ip.loadip.ip_address]  # load balancer k liye jo ip banaya tha wo diya public i;
}
