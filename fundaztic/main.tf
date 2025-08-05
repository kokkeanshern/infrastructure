provider "oci" {
  region = "ap-singapore-1"
}

terraform {
  backend "oci" {
    namespace = "ax1h9bph8nyo"
    bucket    = "terraform-state-backend"
    key       = "fundaztic/dev.tfstate"
    region    = "ap-singapore-1"
  }
}
