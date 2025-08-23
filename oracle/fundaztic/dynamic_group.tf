resource "oci_identity_dynamic_group" "instance_dynamic_group" {
  compartment_id = var.tenancy_ocid
  description    = "Dynamic group for Fundaztic instance management"
  matching_rule  = "ALL {instance.compartment.id = '${var.compartment_id}'}"
  name           = "fundaztic-instance-dynamic-group"
}

resource "oci_identity_policy" "fundaztic_ocir_policy" {
  name           = "fundaztic-ocir-policy"
  description    = "Allow Fundaztic instance dynamic group to pull images from OCIR"
  compartment_id = var.tenancy_ocid
  statements = [
    "Allow dynamic-group fundaztic-instance-dynamic-group to read secret-bundles in compartment id ${var.compartment_id_core}"
  ]
}
