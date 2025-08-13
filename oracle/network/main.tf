provider "oci" {
}

terraform {
  backend "oci" {
    namespace = "ax1h9bph8nyo"
    bucket    = "bucket-tfstate-network"
    key       = "oracle/network/terraform.tfstate"
    region    = "ap-singapore-1"
  }
}
