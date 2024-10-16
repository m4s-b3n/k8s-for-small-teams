variable "ssh_algorithm" {
  description = "The algorithm to use for the TLS certificate."
  type        = string
  default     = "RSA"
}

variable "ssh_rsa_bits" {
  description = "The number of bits to use for the RSA key."
  type        = number
  default     = 4096
}

variable "ssh_ecdsa_curve" {
  description = "The curve to use for the ECDSA key."
  type        = string
  default     = "P384"
}