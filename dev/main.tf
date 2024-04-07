terraform {
    required_providers {
        azurerm = {
        source = "hashicorp/azurerm"
        version = "3.89.0"
        }
    }
    backend "azurerm" {
        # storage_account_name = "tfstatestore20240127"
        # container_name       = "tfstate"
        storage_account_name = "satfstate032424"
        container_name       = "tfstate-container"
        key                  = "dev.terraform.tfstate"
        use_oidc = true
        use_azuread_auth     = true
        subscription_id      = "8b28b648-3c7c-4959-8daa-b9fad32b7b67"
        tenant_id            = "7f0754a3-7e98-4f2a-8435-fd93b7fdd02a"
    }
}

provider "azurerm" {
    # Configuration options
    use_oidc = true
    features {}
}

data "azurerm_resource_group" "myrg" {
    name = "rg-azappsvc-1"
}

data "azurerm_client_config" "current" {}

# resource "azurerm_resource_group" "example" {
#     name = "rg-tfstatetest-2"
#     location = "East US 2"
# }

output "rg_location" {
    value = data.azurerm_resource_group.myrg.location
}

output "current_principal" {
    value = "${ data.azurerm_client_config.current.client_id }"
}