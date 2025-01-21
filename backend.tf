terraform {
  backend "s3" {
    bucket = "week6-adrien-terraform"
    key = "week10/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock-1"
    encrypt = true
  }
}