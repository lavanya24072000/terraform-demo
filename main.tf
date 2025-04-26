# Use a module from the public Terraform Registry
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0" 
  name = "example-vpc"
cidr = "10.0.0.0/16"
 
  azs             = ["us-east-1a"]
private_subnets = ["10.0.1.0/24"]
public_subnets = ["10.0.101.0/24"]
 
  enable_nat_gateway = true
  single_nat_gateway = true
}
 
# Use a module from GitHub
module "s3_bucket" {
source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.14.0"
 
  bucket = "example-github-s3-bucket"


}
 
# Use a module from a local path
module "local_example" {
  source = "./modules/local_example"
 
  instance_type = "t2.micro"
  ami_id        = "ami-084568db4383264d4"
}
