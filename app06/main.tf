# =================== #
# Deploying VMware VM #
# =================== #
# Connect to VMware vSphere vCenter
provider "vsphere" {
user = var.vsphere-user
password = var.vsphere-password
vsphere_server = var.vsphere-vcenter
# If you have a self-signed cert
allow_unverified_ssl = var.vsphere-unverified-ssl
}
# Define VMware vSphere
data "vsphere_datacenter" "dc" {
name = var.vsphere-datacenter
}
data "vsphere_datastore" "datastore" {
name = var.vm-datastore
datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_compute_cluster" "cluster" {
name = var.vsphere-cluster
datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
name = var.vm-network
datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_content_library" "library" {
  name = "SE Template Library"
}
data "vsphere_content_library_item" "library_item_photon" {
  name       = "UBN180405SV00"
  library_id = data.vsphere_content_library.library.id
  type = "OVF"
}

# Create VMs
resource "vsphere_virtual_machine" "vm" {
count = var.vm-count
#name = "${var.vm-name}${count.index + 1}"
name = "${var.vm-name}${format( var.ipv4_address, ( count.index + 1 + var.offset + var.start_ipv4_address))}"
resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
datastore_id = data.vsphere_datastore.datastore.id
num_cpus = var.vm-cpu
memory = var.vm-ram
guest_id = var.vm-guest-id
network_interface {
  network_id = data.vsphere_network.network.id
}
disk {
  label = "${var.vm-name}${count.index + 1}-disk"
  size  = 320
}
clone {
  template_uuid = data.vsphere_content_library_item.library_item_photon.id
  customize {
    timeout = 0

    linux_options {
      host_name = "${var.vm-name}${count.index + 1}"
      domain = var.vm-domain
    }

    network_interface {
      ipv4_address = format(var.ipv4_address, (count.index + 1 + var.offset + var.start_ipv4_address))
      ipv4_netmask = var.ipv4_netmask
    }
    ipv4_gateway = var.ipv4_gateway
    dns_server_list = [var.dns_server_list, var.dns_server_list_1]
    dns_suffix_list = [var.dns_suffix_list]
  }
 }
}
