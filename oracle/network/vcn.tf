module "vcn_shared" {
  source                        = "oracle-terraform-modules/vcn/oci"
  version                       = "3.6.0"
  compartment_id                = var.compartment_id
  region                        = "ap-singapore-1"
  vcn_name                      = "vcn_shared"
  create_internet_gateway       = true # False for now, as the only usecase is for Fundaztic app that does not require public access.
  create_nat_gateway            = true # Fundaztic app requires outbound connection to the internet to send emails.
  create_service_gateway        = true # Fundaztic app requires access to OCI public services (e.g. Object Storage, etc.)
  internet_gateway_display_name = "ig-shared"
  nat_gateway_display_name      = "nat-shared"
  service_gateway_display_name  = "sg-shared"
  vcn_dns_label                 = "shared"
  vcn_cidrs                     = ["10.0.0.0/16"] # 10.0.0.0 - 10.0.0.255.255
}
