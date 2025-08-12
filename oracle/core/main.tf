provider "oci" {
}

terraform {
  backend "oci" {
    namespace = "ax1h9bph8nyo"
    bucket    = "bucket-tfstate-core"
    key       = "oracle/core/terraform.tfstate"
    region    = "ap-singapore-1"
  }
}
