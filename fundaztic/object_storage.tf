variable "oci_compartment_id" {}
variable "oci_namespace" {}

resource "oci_objectstorage_bucket" "test_bucket" {
  compartment_id = var.oci_compartment_id
  name           = "my-test-bucket"
  namespace      = var.oci_namespace
}
