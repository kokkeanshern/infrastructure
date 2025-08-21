###########################################################################
# Terraform Service User                                                  #
###########################################################################

resource "oci_identity_user" "service_user_terraform" {
  compartment_id = var.tenancy_ocid # Always tenancy OCID for users
  name           = "service-user-terraform"
  description    = "user for terraform operations"
  email          = var.service_user_email
}

resource "oci_identity_group" "terraform_service_users_group" {
  compartment_id = var.tenancy_ocid # Always tenancy OCID for groups
  name           = "TerraformServiceUsers"
  description    = "Group for Terraform service accounts"
}

resource "oci_identity_user_group_membership" "terraform_service_user_membership" {
  compartment_id = var.tenancy_ocid
  group_id       = oci_identity_group.terraform_service_users_group.id
  user_id        = oci_identity_user.service_user_terraform.id
}

resource "oci_identity_user_capabilities_management" "service_user_terraform_capabilities_management" {
  user_id                      = oci_identity_user.service_user_terraform.id
  can_use_api_keys             = "true"
  can_use_auth_tokens          = "false"
  can_use_console_password     = "true"
  can_use_customer_secret_keys = "true"
  can_use_smtp_credentials     = "false"
}

resource "oci_identity_policy" "full_admin" {
  name           = "FullAdminAccess"
  description    = "Service account with full control over all resources"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow group TerraformServiceUsers to manage all-resources in tenancy"
  ]
}

###########################################################################
# Docker Service User                                                     #
###########################################################################
resource "oci_identity_user" "service_user_docker" {
  compartment_id = var.tenancy_ocid # Always tenancy OCID for users
  name           = "service-user-docker"
  description    = "user for Docker operations"
  email          = var.service_user_email
}

resource "oci_identity_group" "docker_service_users_group" {
  compartment_id = var.tenancy_ocid # Always tenancy OCID for groups
  name           = "DockerServiceUsers"
  description    = "Group for Docker service accounts"
}

resource "oci_identity_user_group_membership" "docker_service_user_membership" {
  compartment_id = var.tenancy_ocid
  group_id       = oci_identity_group.docker_service_users_group.id
  user_id        = oci_identity_user.service_user_terraform.id
}

resource "oci_identity_policy" "ocir_pull_policy" {
  name           = "ocir-pull-policy"
  description    = "Allows the Docker Service User to read repos in tenancy"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow group DockerServiceUsers to read repos in tenancy",
    "Allow group DockerServiceUsers to read secret-family in compartment id ${module.compartment_core.id}",
    "Allow group DockerServiceUsers to read secret-bundles in compartment id ${module.compartment_core.id}",
    "Allow group DockerServiceUsers to use keys in compartment id ${module.compartment_core.id}"
  ]
}
