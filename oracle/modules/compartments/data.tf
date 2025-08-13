data "oci_identity_groups" "service_user_group" {
  compartment_id = var.tenancy_ocid
  name           = "TerraformServiceUsers"
}
