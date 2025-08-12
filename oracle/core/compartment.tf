resource "oci_identity_compartment" "compartment_core" {
  compartment_id = var.tenancy_ocid # The parent compartment is the root compartment/tenancy
  name           = "compartment-core"
  description    = "compartment for core resources"
  enable_delete  = true
}

resource "oci_identity_compartment" "compartment_fundaztic" {
  compartment_id = var.tenancy_ocid # The parent compartment is the root compartment/tenancy
  name           = "compartment-fundaztic"
  description    = "compartment for fundaztic application resources"
  enable_delete  = true
}

resource "oci_identity_compartment" "compartment_network" {
  compartment_id = var.tenancy_ocid # The parent compartment is the root compartment/tenancy
  name           = "compartment-network"
  description    = "compartment for cloud network resources"
  enable_delete  = true
}
