module "compartment_core" {
  source                = "../modules/compartments"
  name                  = "compartment-core"
  description           = "compartment for core resources"
  parent_compartment_id = var.tenancy_ocid
}

module "compartment_fundaztic" {
  source                = "../modules/compartments"
  name                  = "compartment-fundaztic"
  description           = "compartment for fundaztic resources"
  parent_compartment_id = var.tenancy_ocid
}

module "compartment_network" {
  source                = "../modules/compartments"
  name                  = "compartment-network"
  description           = "compartment for network resources"
  parent_compartment_id = var.tenancy_ocid
}
