variable "tenancy_ocid" {
  description = "The OCID of the tenancy"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaa4gsdatqr4iu26stu45vhvtdy3qtzzapaeztf2wazln2qhxlvfwjq"
}

variable "service_user_email" {
  description = "Email for the service user"
  type        = string
}
