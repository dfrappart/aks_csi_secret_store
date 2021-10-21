######################################################################
# Access to Azure
######################################################################

provider "azurerm" {
  subscription_id                          = var.AzureSubscriptionID
  client_id                                = var.AzureClientID
  client_secret                            = var.AzureClientSecret
  tenant_id                                = var.AzureTenantID

  features {}
  
}



######################################################################
# Add on pod identity through az cli

resource "null_resource" "Install_PodIdentity_Addon" {
  #Use this resource to install AGI on CLI

  provisioner "local-exec" {
    command = "az aks update -n ${data.azurerm_kubernetes_cluster.AKSCluster.name} -g ${data.azurerm_resource_group.AKSRG.name} --enable-pod-identity --enable-pod-identity-with-kubenet"
  }

  depends_on = [

  ]
}



######################################################################
# Add on csi secret store through az cli

resource "null_resource" "Install_CSISecretStore_Addon" {
  #Use this resource to install AGI on CLI
  #count = local.agicaddonstatus == "false" ? 1 : 0
  provisioner "local-exec" {
    command = "az aks enable-addons -n ${data.azurerm_kubernetes_cluster.AKSCluster.name} -g ${data.azurerm_resource_group.AKSRG.name} -a azure-keyvault-secrets-provider --enable-secret-rotation"
  }

  depends_on = [
    null_resource.Install_PodIdentity_Addon
  ]
}

