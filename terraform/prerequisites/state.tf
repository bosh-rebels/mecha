terraform {
  backend "s3" {
    encrypt = true
    bucket  = "genesis-eu-west-1-tf-state-bucket"
    key     = "terraform/prerequisites/terraform.tfstate"
    region  = "eu-west-1"
  }
}