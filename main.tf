# Backend Storage for Statefile
terraform {
  backend "azurerm" {
	resource_group_name  = "gw-icap-tfstate"
    storage_account_name = "tfstate263"
    container_name       = "gw-icap-tfstate"
    key                  = "test.terraform.tfstate"
  }
}

# Cluster Modules
module "create_aks_cluster_UKSouth" {
	source						="./modules/clusters/aks01-uks"
}

module "create_aks_cluster_NorthEurope" {
	source						="./modules/clusters/aks02-neu"
}

module "create_aks_cluster_ARGOCD" {
	source						="./modules/clusters/argocd-command-cluster"
}

# Storage Account Modules
module "create_storage_account_NEU" {
	source						="./modules/storage-accounts/storage-account-neu"
}

module "create_storage_account_UKS" {
	source						="./modules/storage-accounts/storage-account-uks"
}


