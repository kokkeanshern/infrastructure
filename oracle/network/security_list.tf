resource "oci_core_security_list" "security_list_private_shared" {
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_shared.vcn_id
  display_name   = "security-list-private-shared"

  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0" # Anywhere (or restrict to SMTP server IP range)
    destination_type = "CIDR_BLOCK"
    stateless        = false # Stateful connection
  }

  ingress_security_rules {
    protocol    = "6" # TCP
    source_type = "CIDR_BLOCK"
    source      = "14.192.212.150/32"
    tcp_options {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_security_list" "security_list_public_shared" {
  compartment_id = var.compartment_id
  vcn_id         = module.vcn_shared.vcn_id
  display_name   = "security-list-public-shared"

  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0" # Anywhere (or restrict to SMTP server IP range)
    destination_type = "CIDR_BLOCK"
    stateless        = false # Stateful connection
  }

  ingress_security_rules {
    protocol    = "6" # TCP
    source_type = "CIDR_BLOCK"
    source      = "14.192.212.150/32"
    tcp_options {
      min = 22
      max = 22
    }
  }
}
