# Get the tenancy OCID (root compartment)
data "oci_identity_tenancy" "root" {
  tenancy_id = var.tenancy_ocid
}

# Bucket created in root compartment to store statefile for networking-related resources.
resource "oci_objectstorage_bucket" "network_bucket" {
  compartment_id = data.oci_identity_tenancy.root.id
  name           = "network"
  namespace      = "ax1h9bph8nyo"
}
