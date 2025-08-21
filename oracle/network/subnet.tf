# Create private subnet.
resource "oci_core_subnet" "subnet_shared_private" {
  dns_label      = "private"
  display_name   = "subnet-shared-private"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_shared.vcn_id
  cidr_block     = "10.0.1.0/24"
  route_table_id = module.vcn_shared.nat_route_id
  security_list_ids = [
    oci_core_security_list.security_list_private_shared.id
  ]
}

# Create public subnet.
resource "oci_core_subnet" "subnet_shared_public" {
  dns_label      = "public"
  display_name   = "subnet-shared-public"
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_shared.vcn_id
  cidr_block     = "10.0.0.0/24"
  route_table_id = module.vcn_shared.ig_route_id
  security_list_ids = [
    oci_core_security_list.security_list_private_shared.id
  ]
}
