resource "oci_objectstorage_bucket" "bucket_tfstate_core" {
  compartment_id = oci_identity_compartment.compartment_core.id
  name           = "bucket-tfstate-core"
  namespace      = data.oci_objectstorage_namespace.tenant_namespace.namespace
  # Redundant - these are default values.
  access_type           = "NoPublicAccess"
  auto_tiering          = "Disabled"
  object_events_enabled = false
  storage_tier          = "Standard"
  versioning            = "Disabled"
}
