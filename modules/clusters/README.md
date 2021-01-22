# Azure AKS Cluster Creation

These modules will create clusters in certain regions ready for AKS usage.

There is also a cluster that will be created for ArgoCD management. This is used as the main control server for all service deployments to each cluster.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.35.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource\_group | This is a consolidated name based on org, environment, region | `string` | n/a | yes |
| region | The Azure Region | `string` | n/a | yes |
| secret_sp\_1 | This is the name of the secret username for the service principle | `string` | n/a | yes |
| secret_sp\_2 | This is the name of the secret password for the service principle | `string` | n/a | yes |
| cluster\_name | This is a consolidated name based on org, environment, region | `string)` | n/a | yes |
| resource\_group\_name | This is the resource group containing the Azure Key Vault | `string` | n/a | yes |
| keyvault\_name | This is the name for the Azure Key Vault | `string` | n/a | yes |
| vault\_resourcegroup\_name | This is the resource group containing the Azure Key Vault | `string` | n/a | yes |
| node\_name | This is the name of the node | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| resource\_group | n/a |
| cluster\_name | n/a |
| cluster\_dns| n/a |
| secret\_value_1 | n/a |
| secret\_value_2 | n/a |