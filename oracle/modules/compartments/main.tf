resource "oci_identity_compartment" "compartment" {
  compartment_id = var.parent_compartment_id
  name           = var.name
  description    = var.description
  enable_delete  = var.enable_delete
}

resource "oci_identity_policy" "tf_bucket_access" {
  name           = "TFBucketAccess-${var.name}"
  description    = "Allow ${data.oci_identity_groups.service_user_group.groups[0].name} to access Terraform state bucket in ${var.name}"
  compartment_id = var.parent_compartment_id # policies live in the parent compartment

  statements = [
    "Allow group ${data.oci_identity_groups.service_user_group.groups[0].name} to read buckets in compartment ${oci_identity_compartment.compartment.name}",
    "Allow group ${data.oci_identity_groups.service_user_group.groups[0].name} to manage objects in compartment ${oci_identity_compartment.compartment.name}"
  ]
}

output "id" {
  value = oci_identity_compartment.compartment.id
}
