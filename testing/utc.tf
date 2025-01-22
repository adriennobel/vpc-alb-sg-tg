provider "aws" {
  region = "us-east-1"  
}

module "keypair" {
  source = "../modules/keypair"
  key_filename = "testing-key.pem"
  key_key_name = "testing-key"
}