resource "oci_core_instance" "fundaztic_instance" {
  display_name        = "fundaztic-instance"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id

  shape = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = "4"
    ocpus         = "1"
  }

  create_vnic_details {
    assign_ipv6ip             = "false"
    assign_private_dns_record = "true"
    assign_public_ip          = "false"
    display_name              = "vnic-fundaztic"
    subnet_id                 = data.oci_core_subnets.subnet_shared_private.subnets[0].id
    nsg_ids                   = [] # Add network security group IDs if needed
    # route_table_id            = oci_core_route_table.new_route_table.id
  }

  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }

  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }

  source_details {
    source_type = "image"
    source_id   = local.image_id_ubuntu_2404_arm
  }

  metadata = {
    ssh_authorized_keys = file("${path.module}/ssh_keys/instance_fundaztic_ssh_key.pub")
  }

  # metadata = {
  #   user_data = base64encode(
  #     templatefile("${path.module}/cloud_init/cloud-init.sh", {
  #       # oci_username   = var.oci_username
  #       # oci_region     = var.oci_region
  #       # oci_auth_token = var.oci_auth_token
  #       # docker_image   = var.docker_image
  #     })
  #   )
  # }

}
