##############################################################
#config output
##############################################################

output "kuredconfig" {
    value                               = resource.helm_release.kured
    sensitive                           = true
}

output "podidentityconfig" {
    value                               = resource.helm_release.podidentity
    sensitive                           = true
}

#output "csisecretstoreconfig" {
#    value                               = resource.helm_release.csisecretstore
#    sensitive                           = true
#}

output "csisecretstorekvproviderconfig" {
    value                               = resource.helm_release.csisecretstorekvprovider
    sensitive                           = true
}