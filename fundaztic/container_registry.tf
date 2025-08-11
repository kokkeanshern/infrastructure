resource "oci_artifacts_container_repository" "fundaztic" {
  compartment_id = var.compartment_id
  display_name   = "fundaztic"

  is_immutable = false
  is_public    = false

}
