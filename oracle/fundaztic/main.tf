provider "oci" {
}

terraform {
  backend "oci" {
    bucket              = "bucket-tfstate-fundaztic"
    namespace           = "ax1h9bph8nyo"
    key                 = "oracle/fundaztic/terraform.tfstate"
    region              = "ap-singapore-1"
    config_file_profile = "DEFAULT"
  }
}
