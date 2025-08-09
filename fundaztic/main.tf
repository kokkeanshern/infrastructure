provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  fingerprint  = var.fingerprint
  private_key  = var.private_key
  region       = var.region
}

terraform {
  backend "oci" {
    namespace = var.namespace
    bucket    = "terraform-state-backend"
    key       = "fundaztic/dev.tfstate"
    region    = var.region
  }
}
