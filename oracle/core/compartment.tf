resource "oci_identity_compartment" "compartment_core" {
  compartment_id = var.tenancy_ocid # The parent compartment is the root compartment/tenancy
  name           = "compartment-core"
  description    = "compartment for core resources"
  enable_delete  = true
}
