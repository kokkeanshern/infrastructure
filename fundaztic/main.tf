provider "oci" {
}

terraform {
  backend "s3" {
    namespace                   = "ax1h9bph8nyo"
    bucket                      = "terraform-state-backend"
    key                         = "fundaztic/dev.tfstate"
    region                      = "ap-singapore-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    endpoints = {
      s3 = "https://ax1h9bph8nyo.compat.objectstorage.ap-singapore-1.oraclecloud.com"
    }
  }
}
