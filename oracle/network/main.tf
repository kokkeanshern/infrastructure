provider "oci" {
}

terraform {
  backend "oci" {
    namespace = "ax1h9bph8nyo"
    bucket    = "network"
    key       = "network/dev.tfstate"
    region    = "ap-singapore-1"
  }
}
