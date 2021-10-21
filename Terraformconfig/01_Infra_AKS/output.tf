######################################################
# Subscription Output

output "CurrentSubFullOutput" {

  value             = data.azurerm_subscription.current
}

######################################################
#Resource Group ouputs

output "RG1_Name" {

  value             = module.ResourceGroup[0].RGName
}

output "RG1_Location" {

  value             = module.ResourceGroup[0].RGLocation
}

output "RG1_Id" {

  value             = module.ResourceGroup[0].RGId
  sensitive         = true
}


output "RG2_Name" {

  value             = module.ResourceGroup[1].RGName
}

output "RG2_Location" {

  value             = module.ResourceGroup[1].RGLocation
}

output "RG2_Id" {

  value             = module.ResourceGroup[1].RGId
  sensitive         = true
}

######################################################
# Module VNet Outputs
######################################################

##############################################################
#Output for the VNet

output "VNet1_FullOutput" {
  value             = module.AKSVNet[0].VNetFullOutput
  sensitive         = true
}

output "VNet1_Name" {
  value             = module.AKSVNet[0].VNetFullOutput.name
  sensitive         = true
}

output "VNet2_FullOutput" {
  value             = module.AKSVNet[1].VNetFullOutput
  sensitive         = true
}

output "VNet2_Name" {
  value             = module.AKSVNet[1].VNetFullOutput.name
  sensitive         = true
}
##############################################################
# Subnet outputs

# Subnet Bastion

output "AzureBastionSubnet_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AzureBastionSubnetFullOutput
  sensitive         = true
}

output "AzureBastionSubnet_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AzureBastionSubnetFullOutput
  sensitive         = true
}
# Subnet AppGW

output "AGWSubnet_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AGWSubnetFullOutput
  sensitive         = true
}

output "AGWSubnet_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AGWSubnetFullOutput
  sensitive         = true
}
# Subnet FESubnet

output "FESubnet_VNet1_FullOutput" {
  value             = module.AKSVNet[0].FESubnetFullOutput
  sensitive         = true
}

output "FESubnet_VNet2_FullOutput" {
  value             = module.AKSVNet[1].FESubnetFullOutput
  sensitive         = true
}

output "FESubnet_VNet1_Name" {
  value             = module.AKSVNet[0].FESubnetFullOutput.name
  sensitive         = true
}

output "FESubnet_VNet2_Name" {
  value             = module.AKSVNet[1].FESubnetFullOutput.name
  sensitive         = true
}
# Subnet BESubnet

output "BESubnetFull_VNet1_Output" {
  value             = module.AKSVNet[0].BESubnetFullOutput
  sensitive         = true
}

output "BESubnetFull_VNet2_Output" {
  value             = module.AKSVNet[1].BESubnetFullOutput
  sensitive         = true
}

##############################################################
#Outout for NSG

# NSG Bastion Subnet

output "AzureBastionNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AzureBastionNSGFullOutput
  sensitive         = true
}

output "AzureBastionNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AzureBastionNSGFullOutput
  sensitive         = true
}

# NSG AppGW Subnet

output "AGWSubnetNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].AGWSubnetNSGFullOutput
  sensitive         = true
}

output "AGWSubnetNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].AGWSubnetNSGFullOutput
  sensitive         = true
}

# NSG FE Subnet

output "FESubnetNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].FESubnetNSGFullOutput
  sensitive         = true
}

output "FESubnetNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].FESubnetNSGFullOutput
  sensitive         = true
}

# NSG BE Subnet

output "BESubnetNSG_VNet1_FullOutput" {
  value             = module.AKSVNet[0].BESubnetNSGFullOutput
  sensitive         = true
}

output "BESubnetNSG_VNet2_FullOutput" {
  value             = module.AKSVNet[1].BESubnetNSGFullOutput
  sensitive         = true
}


##############################################################
#Output for Bastion Host

output "SpokeBastion_VNET1_FullOutput" {
  value             = module.AKSVNet[0].SpokeBastionFullOutput
  sensitive         = true
}

output "SpokeBastion_VNET2_FullOutput" {
  value             = module.AKSVNet[1].SpokeBastionFullOutput
  sensitive         = true
}

######################################################
# Output for the AKS module with RBAC enabled

output "FullAKS1" {
  value             = module.AKS[0].FullAKS
  sensitive         = true
}


output "AKS1NodeRG" {
  value             = module.AKS[0].FullAKS.node_resource_group
  sensitive         = true
}

output "Kube1Name" {
  value             = module.AKS[0].KubeName
}

output "Kube1Location" {
  value             = module.AKS[0].KubeLocation
}

output "Kube1RG" {
  value             = module.AKS[0].KubeRG
}

output "Kube1Version" {
  value             = module.AKS[0].KubeVersion
}


output "Kube1Id" {
  value             = module.AKS[0].KubeId
  sensitive         = true       
}


output "Kube1FQDN" {
  value             = module.AKS[0].KubeFQDN
}

output "Kube1AdminCFGRaw" {
  value             = module.AKS[0].KubeAdminCFGRaw
  sensitive         = true
}


output "Kube1AdminCFG" {
  value             = module.AKS[0].KubeAdminCFG
  sensitive         = true
}

output "Kube1AdminCFG_UserName" {
  value             = module.AKS[0].KubeAdminCFG_UserName
  sensitive         = true
}

output "Kube1AdminCFG_HostName" {
  value             = module.AKS[0].KubeAdminCFG_HostName
  sensitive         = true
}


output "Kube1AdminCFG_Password" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_Password
}


output "Kube1AdminCFG_ClientKey" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_ClientKey
}


output "Kube1AdminCFG_ClientCertificate" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_ClientCertificate
}

output "Kube1AdminCFG_ClusCACert" {
  sensitive         = true
  value             = module.AKS[0].KubeAdminCFG_ClusCACert
}


output "Kube1ControlPlane_SAI" {
  sensitive         = true
  value             = module.AKS[0].KubeControlPlane_SAI
}

output "Kube1ControlPlane_SAI_PrincipalId" {
  sensitive         = true
  value             = module.AKS[0].KubeControlPlane_SAI_PrincipalId
}

output "Kube1ControlPlane_SAI_TenantId" {
  sensitive         = true
  value             = module.AKS[0].KubeControlPlane_SAI_TenantId
}

output "Kube1Kubelet_UAI" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI
}

output "Kube1Kubelet_UAI_ClientId" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI_ClientId
}

output "Kube1Kubelet_UAI_ObjectId" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI_ObjectId
}

output "Kube1Kubelet_UAI_Id" {
  sensitive         = true
  value             = module.AKS[0].KubeKubelet_UAI_Id
}

output "Kube1_Addons" {
  sensitive         = true
  value             = module.AKS[0].FullAKS.addon_profile
}

output "Kube1_AddonsOMS" {
  sensitive         = true
  value             = module.AKS[0].FullAKS.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}

output "FullAKS2" {
  value             = module.AKS[1].FullAKS
  sensitive         = true
}


output "AKS2NodeRG" {
  value             = module.AKS[1].FullAKS.node_resource_group
  sensitive         = true
}

output "Kube2Name" {
  value             = module.AKS[1].KubeName
}

output "Kube2Location" {
  value             = module.AKS[1].KubeLocation
}

output "Kube2RG" {
  value             = module.AKS[1].KubeRG
}

output "Kube2Version" {
  value             = module.AKS[1].KubeVersion
}


output "Kube2Id" {
  value             = module.AKS[1].KubeId
  sensitive         = true       
}


output "Kube2FQDN" {
  value             = module.AKS[1].KubeFQDN
}

output "Kube2AdminCFGRaw" {
  value             = module.AKS[1].KubeAdminCFGRaw
  sensitive         = true
}


output "Kube2AdminCFG" {
  value             = module.AKS[1].KubeAdminCFG
  sensitive         = true
}

output "Kube2AdminCFG_UserName" {
  value             = module.AKS[1].KubeAdminCFG_UserName
  sensitive         = true
}

output "Kube2AdminCFG_HostName" {
  value             = module.AKS[1].KubeAdminCFG_HostName
  sensitive         = true
}


output "Kube2AdminCFG_Password" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_Password
}


output "Kube2AdminCFG_ClientKey" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_ClientKey
}


output "Kube2AdminCFG_ClientCertificate" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_ClientCertificate
}

output "Kube2AdminCFG_ClusCACert" {
  sensitive         = true
  value             = module.AKS[1].KubeAdminCFG_ClusCACert
}


output "Kube2ControlPlane_SAI" {
  sensitive         = true
  value             = module.AKS[1].KubeControlPlane_SAI
}

output "Kube2ControlPlane_SAI_PrincipalId" {
  sensitive         = true
  value             = module.AKS[1].KubeControlPlane_SAI_PrincipalId
}

output "Kube2ControlPlane_SAI_TenantId" {
  sensitive         = true
  value             = module.AKS[1].KubeControlPlane_SAI_TenantId
}

output "Kube2Kubelet_UAI" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI
}

output "Kube2Kubelet_UAI_ClientId" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI_ClientId
}

output "Kube2Kubelet_UAI_ObjectId" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI_ObjectId
}

output "Kube2Kubelet_UAI_Id" {
  sensitive         = true
  value             = module.AKS[1].KubeKubelet_UAI_Id
}

output "Kube2_Addons" {
  sensitive         = true
  value             = module.AKS[1].FullAKS.addon_profile
}

output "Kube2_AddonsOMS" {
  sensitive         = true
  value             = module.AKS[1].FullAKS.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id
}


/*
######################################################################
# KV Secret module output

output "SecretTest_Id" {
  value             = module.SecretTest_to_KV.Id
  sensitive         = true 
}

output "SecretTest_Version" {
  value             = module.SecretTest_to_KV.Version
  sensitive         = true 
}

output "SecretTest_Name" {
  value             = module.SecretTest_to_KV.Name
  sensitive         = true 
}

output "SecretTest_FullOutput" {
  value             = module.SecretTest_to_KV.SecretFullOutput
  sensitive         = true 
}
*/
######################################################################
# Output for the UAI that will be used in kubernetes
######################################################################
/*

# Module Output

output "UAI1_FullUAIOutput" {
  value                 = module.UAI1.FullUAIOutput
  sensitive             = true
}
output "UAI1_Id" {
  value                 = module.UAI1.Id
  sensitive             = true
}

output "UAI1_Name" {
  value                 = module.UAI1.Name
  sensitive             = false
}

output "UAI1_Location" {
  value                 = module.UAI1.Location
  sensitive             = false
}

output "UAI1_RG" {
  value                 = module.UAI1.RG
  sensitive             = false 
}

output "UAI1_PrincipalId" {
  value                 = module.UAI1.PrincipalId
  sensitive             = true

}

output "UAI1_ClientId" {
  value                 = module.UAI1.ClientId
  sensitive             = true

}

output "UAI1_RBACAssignmentFull" {
  value           = module.UAI1.RBACAssignmentFull
  sensitive       = true
}
output "UAI1_RBACAssignmentGuid" {
  value           = module.UAI1.RBACAssignmentGuid
}

output "UAI1_RBACAssignmentScope" {
  value           = module.UAI1.RBACAssignmentScope
}

output "UAI1_RBACAssignmentRoleName" {
  value           = module.UAI1.RBACAssignmentRoleName
}

output "UAI1_RBACAssignmentPrincipalId" {
  value           = module.UAI1.RBACAssignmentPrincipalId
  sensitive       = true
}

output "UAI1_RBACAssignmentId" {
  value           = module.UAI1.RBACAssignmentId
}

output "UAI1_RBACAssignmentPrincipalType" {
  value           = module.UAI1.RBACAssignmentPrincipalType
}
*/
######################################################################
# Output yaml files for kube resources
######################################################################
/*
output "UAI1_podidentitymanifest" {
  value           = module.UAI1.podidentitymanifest
  sensitive       = true
}

output "UAI1_podidentitybindingmanifest" {
  value           = module.UAI1.podidentitybindingmanifest
  sensitive       = true
}
*/
######################################################################
# Key Vault Access Policy for UAI
/*
output "AKSKeyVaultAccessPolicy_UAI1_Id" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.Id
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_UAI1_KeyVaultId" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.KeyVaultId
  sensitive         = true
}

output "AKSKeyVaultAccessPolicy_UAI1_KeyVaultAcccessPolicyFullOutput" {
  value             = module.AKSKeyVaultAccessPolicy_UAI1.KeyVaultAcccessPolicyFullOutput
  sensitive         = true
}
*/
######################################################################
# Logic App

/*
output "LGAFull" {
  value             = module.LGA_Kured.LGAFull
  sensitive         = true
}
output "LGATrigger" {
  value             = azurerm_logic_app_trigger_http_request.example
  sensitive         = true
}

*/
/*
######################################################################
# Application Gateway output

output "AGWFull" {
  value             = module.AGW.AppGW
  sensitive         = true
}

output "AGWId" {
  value             = module.AGW.AppGW.id
  sensitive         = true
}

output "AGWRG" {
  value             = module.AGW.AppGW.resource_group_name
  sensitive         = true
}

output "AGWName" {
  value             = module.AGW.AppGW.name
  sensitive         = true
}

/*
######################################################################
# Azure policy test

output "policyoutput" {
  value             = data.azurerm_policy_definition.DenyResource
}

output "testjson_to_hcl" {
  value             = jsondecode(file("./policy_sample/policyparam.json"))
}

output "testhcl_to_json" {
  value             = jsonencode(file("./policy_sample/policyparam.txt"))
}

*/


######################################################################
# Kubectl manifest output
output "secretprovidermanifest1" {
  sensitive         = true
  value             = templatefile("./yamltemplate/secretprovider-template.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[0].Name}"
      UAIClientId                         = module.UAI_AKS_CSI[0].ClientId
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[0].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
}

output "secretprovidermanifest2" {
  sensitive         = true
  value             = templatefile("./yamltemplate/secretprovider-template.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[1].Name}"
      UAIClientId                         = module.UAI_AKS_CSI[1].ClientId
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[1].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
}

output "podexample1Manifest" {
  sensitive         = true
  value             = templatefile("./yamltemplate/TestPod-template.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[0].Name}"
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[0].Name}"
      UAIName                             = module.UAI_AKS_CSI[0].Name
    }
  )
}

output "podexample2Manifest" {
  sensitive         = true
  value             = templatefile("./yamltemplate/TestPod-template.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[1].Name}"
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[1].Name}"
      UAIName                             = module.UAI_AKS_CSI[1].Name
    }
  )
}

output "podidentitymanifest1" {
  sensitive         = true
  value             = module.UAI_AKS_CSI[0].podidentitymanifest
}

output "podidentitybindingmanifest2" {
  sensitive         = true
  value             = module.UAI_AKS_CSI[1].podidentitybindingmanifest
}

output "podidentitymanifestList" {
  sensitive         = true
  value             = module.UAI_AKS_CSI[*].podidentitymanifest
}

output "secretproviderwithaddonManifest" {
  sensitive         = true
  value             = templatefile("./yamltemplate/secretprovider-template-addon.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}-azurekeyvaultsecretsprovider-${module.AKS[0].KubeName}"
      CSIAddonUAIClientId                 = "6fd7e2a8-037f-4c6c-8ac3-536a80dd3551" #For now, since tf cannot view the addon, there is no simple way to get the identity client id in an output
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[0].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  ) 
}

output "podexamplewAddonManifest" {
  sensitive         = true
  value             = templatefile("./yamltemplate/TestPod-template-csiaddon.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}-azurekeyvaultsecretsprovider-${module.AKS[0].KubeName}"
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}-azurekeyvaultsecretsprovider-${module.AKS[0].KubeName}"
    }
  )
}

output "secretprovidersyncsecretManifest1" {
  sensitive         = true
  value             = templatefile("./yamltemplate/secretprovider-templatesyncsecret.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[0].Name}syncsecret"
      UAIClientId                         = module.UAI_AKS_CSI[0].ClientId
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[0].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
}

output "secretprovidersyncsecretManifest2" {
  sensitive         = true
  value             = templatefile("./yamltemplate/secretprovider-templatesyncsecret.yaml",
    {
      SecretProviderClassName             = "${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[1].Name}syncsecret"
      UAIClientId                         = module.UAI_AKS_CSI[1].ClientId
      KVName                              = data.azurerm_key_vault.aks_agw_keyvault.name
      SecretName                          = module.SecretTest_to_KV[1].SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
}

output "nginxpodexamplesyncManifest1" {
  sensitive         = true
  value             = templatefile("./yamltemplate/TestPod-template-secretsync.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[0].Name}"
      SecretProviderClassName             = data.azurerm_key_vault.aks_agw_keyvault.name
    }
  )
}

output "nginxpodexamplesyncManifest2" {
  sensitive         = true
  value             = templatefile("./yamltemplate/TestPod-template-secretsync.yaml",
    {
      PodName                             = "pod-${data.azurerm_key_vault.aks_agw_keyvault.name}${module.UAI_AKS_CSI[1].Name}"
      SecretProviderClassName             = data.azurerm_key_vault.aks_agw_keyvault.name
    }
  )
}

