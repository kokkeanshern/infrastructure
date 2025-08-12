resource "oci_identity_user" "service_user_terraform" {
  compartment_id = oci_identity_compartment.compartment_core.compartment_id
  name           = "service-user-terraform"
  description    = "user for terraform operations"
  email          = var.service_user_email
}

resource "oci_identity_user_capabilities_management" "service_user_terraform_capabilities_management" {
  user_id                      = oci_identity_user.service_user_terraform.id
  can_use_api_keys             = "true"
  can_use_auth_tokens          = "false"
  can_use_console_password     = "true"
  can_use_customer_secret_keys = "true"
  can_use_smtp_credentials     = "false"
}
