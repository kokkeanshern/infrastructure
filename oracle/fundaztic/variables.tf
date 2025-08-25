variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created."
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaawutq5bmyehb2obqa3hcvstm5gzmboh62p7ixwwhdvgz2r73kvynq"
}

variable "compartment_id_network" {
  description = "The OCID of the compartment where resources will be created."
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaabhm4uivzzdkeowpjp7kfcrdmp5ci7a4tthfxqjlbso7736kkeqma"
}

variable "compartment_id_core" {
  description = "The OCID of the compartment where resources will be created."
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaad4rrzhwjg3ssfpepxv72ha27vscps7mll4gzwu3buxoqa63proca"
}

variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaa4gsdatqr4iu26stu45vhvtdy3qtzzapaeztf2wazln2qhxlvfwjq"
}
