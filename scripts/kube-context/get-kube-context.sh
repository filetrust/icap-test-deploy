#!/bin/bash

# AKS Variables
NEU_RESOURCE_GROUP="icap-test-deploy-neu"
NEU_AKS_NAME="icap-test-aks-neu"

UKS_RESOURCE_GROUP="icap-test-deploy-uks"
UKS_AKS_NAME="icap-test-aks-uks"

ARGOCD_RESOURCE_GROUP="icap-test-argocd"
ARGOCD_AKS_NAME="icap-test-argocd-central"


az aks get-credentials --resource-group $NEU_RESOURCE_GROUP --name $NEU_AKS_NAME

az aks get-credentials --resource-group $UKS_RESOURCE_GROUP --name $UKS_AKS_NAME

az aks get-credentials --resource-group $ARGOCD_RESOURCE_GROUP --name $ARGOCD_AKS_NAME