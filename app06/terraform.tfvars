# VMware VMs configuration #
vm-count = "4"
vm-name = "054-infra-auto-"
vm-template-name = "N/A"
vm-cpu = "4"
vm-ram = "8192"
vm-guest-id = "ubuntu64Guest"
# VMware vSphere configuration #
# VMware vCenter IP/FQDN
vsphere-vcenter = "p054vmwvcsa01.epiqcorp.com"
# VMware vSphere username used to deploy the infrastructure
vsphere-user = "Christopher.Faria@epiqsystems.com"
# VMware vSphere password used to deploy the infrastructure
vsphere-password = "password"
# Skip the verification of the vCenter SSL certificate (true/false)
vsphere-unverified-ssl = "true"
# vSphere datacenter name where the infrastructure will be deployed
vsphere-datacenter = "054SuperNAPLV"
# vSphere cluster name where the infrastructure will be deployed
vsphere-cluster = "P054POD03CMP00"
# vSphere Datastore used to deploy VMs
vm-datastore = "P054POD03CMP00DS00"
# vSphere Network used to deploy VMs
vm-network = "p054pod03cmp00vs01-623"
# Linux virtual machine domain name
vm-domain = "epiqcorp.com"
# starting IP address
start_ipv4_address = "18"
offset = "1"
ipv4_gateway ="10.76.46.1"
ipv4_address ="10.76.46.%d"
ipv4_netmask ="24"
dns_server_list ="10.255.0.10"
dns_server_list_1 ="10.255.0.11"
dns_suffix_list ="epiqcorp.com"
