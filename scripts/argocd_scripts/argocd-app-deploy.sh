#!/bin/sh

# Cluster Resource Group Variables
UKS_RESOURCE_GROUP="icap-test-deploy-uks"
NEU_RESOURCE_GROUP="icap-test-deploy-neu"

# Cluster FQDN Variables
UKS_CLUSTER_FQDN=$(az aks list -g $UKS_RESOURCE_GROUP --query "[].fqdn" | awk 'FNR == 2' | tr -d '",\040')
NEU_CLUSTER_FQDN=$(az aks list -g $NEU_RESOURCE_GROUP --query "[].fqdn" | awk 'FNR == 2' | tr -d '",\040')

# App Name
ADAPTATION_SERVICE="icap-adaptation-service"
ADMINISTRATION_SERVICE="icap-administration-service"
NCFS_SERVICE="icap-ncfs-service"
RABBITMQ_OPERATOR="rabbitmq-operator"
CERT_MANAGER="cert-manager"

# Cluster Context
NEU_CONTEXT="icap-test-aks-neu"
UKS_CONTEXT="icap-test-aks-uks"

# App Paths
PATH_ADAPTATION="adaptation"
PATH_ADMINISTRATION="administration"
PATH_NCFS="ncfs"
PATH_RABBITMQ="rabbitmq-operator"
PATH_CERT="cert-manager-chart"

# Namespaces
NS_ADAPTATION="icap-adaptation"
NS_ADMINISTRATION="icap-administration"
NS_NCFS="icap-ncfs"
NS_RABBIT="icap-rabbit-operator"

# Revisions
REV_MAIN="main"
REV_DEVELOP="develop"

# Parameters
PARAM_REMOVE_SECRETS="secrets=null"

# Github repo
ICAP_REPO="https://github.com/filetrust/icap-infrastructure"

# Switch to argo context
kubectl config use-context icap-test-argocd-central

# Add Cluster
argocd cluster add $NEU_CONTEXT
argocd cluster add $UKS_CONTEXT

# Create NEU Cluster Apps
argocd app create $RABBITMQ_OPERATOR-neu-test --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $ADAPTATION_SERVICE-neu-test --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $ADMINISTRATION_SERVICE-neu-test --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $NCFS_SERVICE-neu-test --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $CERT_MANAGER-neu-test --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$NEU_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_DEVELOP

# # Create UKS Cluster Apps
argocd app create $RABBITMQ_OPERATOR-uks-test --repo $ICAP_REPO --path $PATH_RABBITMQ --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_RABBIT --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $ADAPTATION_SERVICE-uks-test --repo $ICAP_REPO --path $PATH_ADAPTATION --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADAPTATION --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $ADMINISTRATION_SERVICE-uks-test --repo $ICAP_REPO --path $PATH_ADMINISTRATION --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_ADMINISTRATION --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $NCFS_SERVICE-uks-test --repo $ICAP_REPO --path $PATH_NCFS --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace $NS_NCFS --revision $REV_DEVELOP --parameter $PARAM_REMOVE_SECRETS

argocd app create $CERT_MANAGER-uks-test --repo $ICAP_REPO --path $PATH_CERT --dest-server https://$UKS_CLUSTER_FQDN:443 --dest-namespace default --revision $REV_DEVELOP
