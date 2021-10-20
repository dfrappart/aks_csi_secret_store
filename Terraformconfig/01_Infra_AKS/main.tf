######################################################################
# backend block for partial configuration
######################################################################
terraform {
  backend "azurerm" {}
}

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
# Module call
######################################################################

# Creating the Resource Group

module "ResourceGroup" {
  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = "${var.ResourcesSuffix}${count.index+1}"
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}


module "AKSVNet" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_NTW_VNet_for_AppGW/"

  #Module variable
  RGLogName                               = data.azurerm_resource_group.RGLog.name
  LawSubLogName                           = data.azurerm_log_analytics_workspace.LAWLog.name
  STALogId                                = data.azurerm_storage_account.STALog.id
  TargetRG                                = module.ResourceGroup[count.index].RGName
  TargetLocation                          = module.ResourceGroup[count.index].RGLocation
  VNetSuffix                              = "${var.ResourcesSuffix}${count.index+1}"

  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}


######################################################################
# Module for AKS

# UAI for AKS

module "UAI_AKS" {

  count                                   = 2
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/441_UserAssignedIdentity/"
  
  #Module variable
  UAISuffix                               = "aks-${lower(var.AKSClusSuffix)}${count.index+1}"
  TargetRG                                = module.ResourceGroup[count.index].RGName

}

module "AKS" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Custom_Modules/IaaS_AKS_ClusterwithRBAC_AzureCNI/"

  #Module variable
  STASubLogId                             = data.azurerm_storage_account.STALog.id
  LawSubLogId                             = data.azurerm_log_analytics_workspace.LAWLog.id

  AKSLocation                             = module.ResourceGroup[count.index].RGLocation
  AKSRGName                               = module.ResourceGroup[count.index].RGName
  AKSSubnetId                             = module.AKSVNet[count.index].FESubnetFullOutput.id
  AKSNetworkPlugin                        = "kubenet"
  AKSClusSuffix                           = "${var.AKSClusSuffix}${count.index+1}"
  AKSIdentityType                         = "UserAssigned"
  UAIId                                   = module.UAI_AKS[count.index].FullUAIOutput.id
  PublicSSHKey                            = data.azurerm_key_vault_secret.AKSSSHKey.name
  #IsAGICEnabled                           = true
  #AGWId                                   = module.AGW.AppGW.id
  #PrivateClusterPublicFqdn                = true
  #PrivateDNSZoneId                        = "None"   #"/subscriptions/16e85b36-5c9d-48cc-a45d-c672a4393c36/resourceGroups/rsg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.westeurope.azmk8s.io"
  #IsAKSPrivate                            = var.IsAKSPrivate
  AutoUpgradeChannelConfig                = null
  ACG1Id                                  = data.azurerm_monitor_action_group.SubACG.id
  AKSClusterAdminsIds                     = [var.AKSClusterAdminsIds]
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

}




######################################################################
# Requirement for Pod Identity
######################################################################

######################################################################
# Mapping AKS SAI to subscription - Managed Identity Operator

module "AssignAKS_SAI_ManagedIdentityOps_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.UAI_AKS[count.index].PrincipalId

}

######################################################################
# Mapping AKS SAI to VNet

module "AssignAKS_SAI_VMContributor_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.UAI_AKS[count.index].PrincipalId

}



######################################################################
# Mapping AKS Kubelet UAI to subscription - Managed Identity Operator

module "AssignAKS_KubeletUAI_ManagedIdentityOps_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Managed Identity Operator"
  ObjectId                                = module.AKS[count.index].FullAKS.kubelet_identity[0].object_id
  #module.AKS1.KubeControlPlane_SAI_PrincipalId

}

######################################################################
# Mapping AKS Kubelet UAI to VM Operator role

module "AssignAKS_KubeletUAI_VMContributor_To_Sub" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks/401_RBACAssignment_BuiltinRole/"

  #Module variable
  RBACScope                               = data.azurerm_subscription.current.id
  BuiltinRoleName                         = "Virtual Machine Contributor"
  ObjectId                                = module.AKS[count.index].FullAKS.kubelet_identity[0].object_id

}





######################################################################
# Creating a RG and LGA for kured

# Creating the Resource Group

module "ResourceGroup_Kured" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//003_ResourceGroup/"
  #Module variable      
  RGSuffix                                = "${var.ResourcesSuffix}kured${count.index+1}"
  RGLocation                              = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

module "LGA_Kured" {

  count                                   = 2 
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest//Modules_building_blocks//700_LogicAppBasic/"
  #Module variable      
  LGASuffix                               = "${var.ResourcesSuffix}kured${count.index+1}"
  RGName                                  = module.ResourceGroup_Kured[count.index].RGFull.name
  LGALocation                             = var.AzureRegion
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  EnvironmentTag                          = var.Environment
  Project                                 = var.Project

}

resource "azurerm_logic_app_trigger_http_request" "testhttptriggerlga" {
  count        = 1
  name         = "testhttptriggerlga${count.index+1}"
  logic_app_id = module.LGA_Kured[count.index].LGAFull.id

  schema = <<SCHEMA
{
    "type": "object",
    "properties": {
        "Channel": {
            "type": "string"
        },
        "Text": {
            "type": "string"
        },
        "Username": {
            "type": "string"
        }
    }
}
                    
SCHEMA

}

######################################################################
# Creating Secrets in kv for demo purpose

module "SecretTest_to_KV" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/412_KeyvaultSecret/"

  #Module variable     
  KeyVaultSecretSuffix                    = "CSISecret${count.index+1}"
  #PasswordValue                           = module.SecretTest.Result
  KeyVaultId                              = data.azurerm_key_vault.aks_agw_keyvault.id
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project

  depends_on = [

  ]

}


######################################################################
# Creating a UAI for Kubernetes and CSI Demo with Pod Identity

module "UAI_AKS_CSI" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest/Custom_Modules/Kube_UAI/"

  #Module variable
  UAISuffix                               = "CSITest${count.index+1}"
  TargetLocation                          = module.ResourceGroup[count.index].RGLocation
  TargetRG                                = module.ResourceGroup[count.index].RGName
  RBACScope                               = module.ResourceGroup[count.index].RGId
  BuiltinRoleName                         = "Reader"
  ResourceOwnerTag                        = var.ResourceOwnerTag
  CountryTag                              = var.CountryTag
  CostCenterTag                           = var.CostCenterTag
  Environment                             = var.Environment
  Project                                 = var.Project


}

# Creating file manifest for csi demo

resource "local_file" "podidentitymanifest" {
  count                                   = 2
  content                                 = module.UAI_AKS_CSI[count.index].podidentitymanifest
  filename                                = "../04_CSI_Secret_Store_Manifest/PodId/${module.UAI_AKS_CSI[count.index].Name}.yaml"
}

resource "local_file" "podidentitybindingmanifest" {
  count                                   = 2
  content                                 = module.UAI_AKS_CSI[count.index].podidentitybindingmanifest
  filename                                = "../04_CSI_Secret_Store_Manifest/PodId/${module.UAI_AKS_CSI[count.index].Name}_Binding.yaml"
}

resource "local_file" "secretprovider" {
  count                                   = 2
  content                                 = templatefile("./yamltemplate/secretprovider-template.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[count.index].Name}"
      UAIClientId                         = module.UAI_AKS_CSI[count.index].ClientId
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[count.index].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
  filename = "../04_CSI_Secret_Store_Manifest/SecretStore/${lower(data.azurerm_key_vault.aks_agw_keyvault.name)}${count.index+1}-podid-secretstore.yaml"
}

resource "local_file" "podexample" {
  count                                   = 2
  content                                 = templatefile("./yamltemplate/TestPod-template.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[count.index].Name}"
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[count.index].Name}"
    }
  )
  filename = "../04_CSI_Secret_Store_Manifest/demo-pod${count.index+1}.yaml"
}

# Granting access to UAI on the target kv

module "AKSKeyVaultAccessPolicy_UAI_AKS_CSI" {

  count                                   = 2
  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/411_KeyVault_Access_Policy/"

  #Module variable     
  VaultId                                 = data.azurerm_key_vault.aks_agw_keyvault.id
  KeyVaultTenantId                        = data.azurerm_subscription.current.tenant_id
  KeyVaultAPObjectId                      = module.UAI_AKS_CSI[count.index].PrincipalId
  Secretperms                             = var.Secretperms_UAI_AKS_CSI_AccessPolicy

  depends_on = [

  ]

}

######################################################################
# Creating the file for the CSI with the addon identity


# Creating the manifest file for the secret provider class
resource "local_file" "secretproviderwithaddon" {

  content                                 = templatefile("./yamltemplate/secretprovider-template-addon.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}-azurekeyvaultsecretsprovider-${module.AKS[0].KubeName}"
      CSIAddonUAIClientId                 = "6fd7e2a8-037f-4c6c-8ac3-536a80dd3551" #For now, since tf cannot view the addon, there is no simple way to get the identity client id in an output
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[0].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
  filename = "../04_CSI_Secret_Store_Manifest/SecretStore/${lower(data.azurerm_key_vault.aks_agw_keyvault.name)}-secretstore-withaddon.yaml"
}

# Granting access to addon UAI on the target kv
module "AKSKeyVaultAccessPolicy_UAI_AKS_CSIAddon" {


  #Module Location
  source                                  = "github.com/dfrappart/Terra-AZModuletest/Modules_building_blocks/411_KeyVault_Access_Policy/"

  #Module variable     
  VaultId                                 = data.azurerm_key_vault.aks_agw_keyvault.id
  KeyVaultTenantId                        = data.azurerm_subscription.current.tenant_id
  KeyVaultAPObjectId                      = "26f20699-42a9-4f7b-aacb-bb85d5bb5bed" #For now, since tf cannot view the addon, there is no simple way to get the identity client id in an output
  Secretperms                             = var.Secretperms_UAI_AKS_CSI_AccessPolicy

  depends_on = [

  ]

}

resource "local_file" "podexamplewithaddon" {
  content                                 = templatefile("./yamltemplate/TestPod-template-csiaddon.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}-azurekeyvaultsecretsprovider-${module.AKS[0].KubeName}"
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}-azurekeyvaultsecretsprovider-${module.AKS[0].KubeName}"
    }
  )
  filename = "../04_CSI_Secret_Store_Manifest/demo-pod-csiaddon.yaml"
}

######################################################################
# Creating the file for the CSI with the sync secret option

resource "local_file" "secretprovidersyncsecret" {
  count                                   = 2
  content                                 = templatefile("./yamltemplate/secretprovider-templatesyncsecret.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[count.index].Name}syncsecret"
      UAIClientId                         = module.UAI_AKS_CSI[count.index].ClientId
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[count.index].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
  filename = "../04_CSI_Secret_Store_Manifest/SecretStore/${lower(data.azurerm_key_vault.aks_agw_keyvault.name)}${count.index+1}-secretstore-synctosecret.yaml"
}

resource "local_file" "nginxpodexamplesyncsecret" {
  count                                   = 2
  content                                 = templatefile("./yamltemplate/TestPod-template-secretsync.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[count.index].Name}"
      SecretProviderClassName             = data.azurerm_key_vault.aks_agw_keyvault.name
    }
  )
  filename = "../04_CSI_Secret_Store_Manifest/demopod-syncsecret${count.index}.yaml"
}

