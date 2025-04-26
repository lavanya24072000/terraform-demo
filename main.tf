# Use a module from the public Terraform Registry
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"
 
  name = "example-vpc"
cidr = "10.0.0.0/16"
 
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
 
  enable_nat_gateway = true
  single_nat_gateway = true
}
 
# Use a module from GitHub
module "s3_bucket" {
source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.14.0"
 
  bucket = "example-github-s3-bucket"
  acl    = "private"
}
 
# Use a module from a local path
module "local_example" {
  source = "./modules/local_example"
 
  instance_type = "t2.micro"
  ami_id        = "ami-0c55b159cbfafe1f0"
}