######################################################################
# Webshop K8S + Storage resources
######################################################################

######################################################################
# Access to terraform
######################################################################

terraform {

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id         = var.AzureSubscriptionID
  client_id               = var.AzureClientID
  client_secret           = var.AzureClientSecret
  tenant_id               = var.AzureTenantID

  features {}
}

provider "kubernetes" {

  host                    = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.host #module.AKSClus.KubeAdminCFG_HostName
  username                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.username
  password                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.password
  client_certificate      = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_certificate)
  client_key              = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_key)
  cluster_ca_certificate  = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.cluster_ca_certificate)

}


provider "helm" {
  kubernetes {

  host                    = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.host #module.AKSClus.KubeAdminCFG_HostName
  username                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.username
  password                = data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.password
  client_certificate      = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_certificate)
  client_key              = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.client_key)
  cluster_ca_certificate  = base64decode(data.azurerm_kubernetes_cluster.AKSCluster.kube_admin_config.0.cluster_ca_certificate)

  }
}

locals {

  ResourcePrefix                        = "${lower(var.Company)}${lower(var.CountryTag)}"

}



######################################################################
# installing kured from helm

resource "helm_release" "kured" {
  name                                = "kured"
  repository                          = "https://weaveworks.github.io/kured"
  chart                               = "kured"
  version                             = var.kuredChartVer
  namespace                           = "kured"
  create_namespace                    = true

  dynamic "set" {
    for_each                          = var.HelmKuredParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }

  set_sensitive {
    name                              = var.HelmKuredSensitiveParamName
    value                             = var.HelmKuredSensitiveParamValue
  }
}

######################################################################
# installing pod identity from helm

resource "helm_release" "podidentity" {
  name                                = "podidentity"
  repository                          = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart                               = "aad-pod-identity"
  version                             = var.PodIdChartVer
  namespace                           = "podidentity"
  create_namespace                    = true


  dynamic "set" {
    for_each                          = var.HelmPodIdentityParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }

  depends_on = [
    
  ]

}

######################################################################
# installing csi secret store from helm
/*
resource "helm_release" "csisecretstore" {
  name                                = "secrets-store-csi-driver"
  repository                          = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart                               = "secrets-store-csi-driver"
  version                             = var.CSISecretStoreChartVer
  namespace                           = "csisecretstore"
  create_namespace                    = true

  dynamic "set" {
    for_each                          = var.HelmCSISecretStoreParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }



  depends_on = [
    
  ]

}
*/
######################################################################
# installing csi secret store key vault provider from helm

resource "helm_release" "csisecretstorekvprovider" {
  name                                = "csisecretstorekvprovider"
  repository                          = "https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts"
  chart                               = "csi-secrets-store-provider-azure"
  version                             = var.CSISecretStoreKvPRoviderChartVer
  namespace                           = "csisecretstorekvprovider"
  create_namespace                    = true

  dynamic "set" {
    for_each                          = var.HelmCSISecretStoreKVProviderParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }


  depends_on = [
    #helm_release.csisecretstore
  ]

}