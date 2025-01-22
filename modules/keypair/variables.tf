variable "key_algorithm" {
  description = "The algorithm to use for the key pair"
  type        = string
  default     = "RSA"
}

variable "key_rsa_bits" {
  description = "The number of bits to use for the key pair"
  type        = number
  default     = 2048
}

variable "key_key_name" {
  description = "The name of the key pair"
  type        = string
}

variable "key_filename" {
  description = "The filename to use for the key pair"
  type        = string
}

variable "key_file_permission" {
  description = "The file permission to use for the key pair"
  type        = number
  default     = 400  
}