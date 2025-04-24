terraform {
  backend "s3" {
    bucket = "your-s3-bucket"
    key    = "terraform/state/network_infra.tfstate"
    region = "us-east-1"
  }
}