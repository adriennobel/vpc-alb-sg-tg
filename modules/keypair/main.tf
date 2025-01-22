# generate key pair
resource "tls_private_key" "tls" {
  algorithm = var.key_algorithm
  rsa_bits = var.key_rsa_bits
}

resource "aws_key_pair" "key" {
  key_name = var.key_key_name
  public_key = tls_private_key.tls.public_key_openssh
}

resource "local_file" "key1" {
  filename = var.key_filename
  content = tls_private_key.tls.private_key_pem
  file_permission = var.key_file_permission
}