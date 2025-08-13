provider "oci" {
}

terraform {
  backend "oci" {
    namespace = "ax1h9bph8nyo"
    bucket    = "bucket-tfstate-fundaztic"
    key       = "oracle/fundaztic/terraform.tfstate"
    region    = "ap-singapore-1"
  }
}
