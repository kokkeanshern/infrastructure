variable "name" {
  description = "Name of the compartment"
  type        = string
}

variable "description" {
  description = "Description of the compartment"
  type        = string
}

variable "parent_compartment_id" {
  description = "Parent compartment OCID (use tenancy_ocid for root)"
  type        = string
}

variable "enable_delete" {
  description = "Whether the compartment can be deleted"
  type        = bool
  default     = true
}

variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaa4gsdatqr4iu26stu45vhvtdy3qtzzapaeztf2wazln2qhxlvfwjq"
}
