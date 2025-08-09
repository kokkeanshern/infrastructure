resource "oci_objectstorage_bucket" "test_bucket" {
  compartment_id = var.compartment_id
  name           = "my-test-bucket"
  namespace      = var.namespace
}
