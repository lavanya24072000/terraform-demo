terraform {
  backend "s3" {
    bucket = "lavanya-bucket001"
    key    = "terraform/state/network_infra.tfstate"
    region = "us-east-1"
    
  }
}
