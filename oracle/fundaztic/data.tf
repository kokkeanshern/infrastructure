data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_vcns" "vcn_shared" {
  compartment_id = var.compartment_id
  display_name   = "vcn-shared"
}

data "oci_core_subnets" "subnet_shared_private" {
  compartment_id = var.compartment_id
  display_name   = "subnet-shared-private"
  vcn_id         = data.oci_core_vcns.vcn_shared.virtual_networks[0].id
}

locals {
  image_id_ubuntu_2404_arm = "ocid1.image.oc1.ap-singapore-1.aaaaaaaaqnq4vkvwbtr4k4gcmvamshtworusoi54vuwixafhg6jax7lgydta"
}
