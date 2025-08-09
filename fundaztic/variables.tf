variable "tenancy_ocid" {
  type        = string
  description = "OCI Tenancy OCID"
}
#dummy comment
variable "user_ocid" {
  type        = string
  description = "OCI User OCID"
}

variable "fingerprint" {
  type        = string
  description = "API Key fingerprint"
}

variable "compartment_id" {
  type        = string
  description = "Compartment OCID"
}

variable "private_key" {
  type        = string
  description = "Private key for API authentication"
}

variable "region" {
  type        = string
  description = "OCI Region"
  default     = "ap-singapore-1"
}

variable "namespace" {
  type        = string
  description = "OCI Object Storage Namespace"
}
