resource "oci_kms_vault" "core_vault" {
  compartment_id = module.compartment_core.id
  display_name   = "core-vault"
  vault_type     = "DEFAULT"
}

resource "oci_kms_key" "core_kms_key" {
  compartment_id  = module.compartment_core.id
  display_name    = "core-kms-key"
  protection_mode = "SOFTWARE"
  key_shape {
    algorithm = "AES"
    length    = 32
  }
  management_endpoint = oci_kms_vault.core_vault.management_endpoint
}
