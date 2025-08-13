# Terraform statefile buckets only.
resource "oci_objectstorage_bucket" "bucket_tfstate_core" {
  compartment_id = module.compartment_core.id
  name           = "bucket-tfstate-core"
  namespace      = data.oci_objectstorage_namespace.tenant_namespace.namespace
  # Redundant - these are default values.
  access_type           = "NoPublicAccess"
  auto_tiering          = "Disabled"
  object_events_enabled = false
  storage_tier          = "Standard"
  versioning            = "Disabled"
}

resource "oci_objectstorage_bucket" "bucket_tfstate_fundaztic" {
  compartment_id = module.compartment_fundaztic.id
  name           = "bucket-tfstate-fundaztic"
  namespace      = data.oci_objectstorage_namespace.tenant_namespace.namespace
  # Redundant - these are default values.
  access_type           = "NoPublicAccess"
  auto_tiering          = "Disabled"
  object_events_enabled = false
  storage_tier          = "Standard"
  versioning            = "Disabled"
}

resource "oci_objectstorage_bucket" "bucket_tfstate_network" {
  compartment_id = module.compartment_network.id
  name           = "bucket-tfstate-network"
  namespace      = data.oci_objectstorage_namespace.tenant_namespace.namespace
  # Redundant - these are default values.
  access_type           = "NoPublicAccess"
  auto_tiering          = "Disabled"
  object_events_enabled = false
  storage_tier          = "Standard"
  versioning            = "Disabled"
}
