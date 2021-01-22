# Azure Key Vault Creation

The modules will create the 

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.35.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource\_group\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |
| region | The Azure Region/location the resource will be installed | `string` | n/a | yes |
| file\_share\_name01 | The name of the file share | `string` | n/a | yes |
| file\_share\_name02 | The name of the file share | `string` | n/a | yes |
| account\_tier | The tier of storage account | `string` | n/a | yes |
| account\_kind| The kind of the storage account (cool, hot, archive) | `string` | n/a | yes |
| application\_replication\_type | The Storage Account replication type | `string` | n/a | yes |
| access\_tier | The name of the key vault | `string` | n/a | yes |