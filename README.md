# Terraform Multi-Module Deployment (Public, GitHub, and Local Modules)
 
## Overview
 
This project demonstrates how to use different types of Terraform modules:
- Public Terraform Registry module (`terraform-aws-modules/vpc/aws`)
- GitHub module (`terraform-aws-modules/terraform-aws-s3-bucket`)
- Local module (`modules/local_example`)
 
Infrastructure is provisioned automatically via GitHub Actions workflow.
 
---
 
## Folder Structure
 
```plaintext
.github/
└── workflows/
    └── deploy.yaml          # GitHub Actions workflow
 
modules/
└── local_example/
├── main.tf              # Local module logic
├── outputs.tf           # Outputs for local module
└── variables.tf         # Variables for local module
 
main.tf                      # Root Terraform configuration
outputs.tf                   # Root Terraform outputs
variables.tf                  # Root Terraform variables
Modules Used

**1. Public Module (Terraform Registry)**
Using the VPC module:
 
hcl
Copy code
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"
 
  name                = "example-vpc"
  cidr = "10.0.0.0/16"
  azs                 = ["us-east-1a"]
private_subnets = ["10.0.1.0/24"]
public_subnets = ["10.0.101.0/24"]
  enable_nat_gateway  = true
  single_nat_gateway  = true
}
**2. GitHub Module**
Using an S3 bucket module directly from GitHub:
 
hcl
Copy code
module "s3_bucket" {
source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git//?ref=v3.14.0"
 
  bucket = "example-github-s3-bucket"
}
**3. Local Module**
Using a local module from the repository:
 
hcl
Copy code
module "local_example" {
  source = "./modules/local_example"
 
  instance_type = "t2.micro"
  ami_id        = "ami-084568db4383264d4"
}
**GitHub Actions Workflow**
Workflow File: .github/workflows/deploy.yaml
 
Trigger: Manual (workflow_dispatch)
 
Main Steps:
 
Checkout the repository
 
Configure AWS credentials
 
Setup Terraform
 
Terraform Init
 
Terraform Plan
 
Terraform Apply
 
**How to Deploy**
Push your code to GitHub.
 
Go to the Actions tab on GitHub.
 
Select the Provision Infra workflow.
 
Click on Run workflow.
 
Terraform will:
 
Create a VPC using the public module.
 
Create an S3 bucket using the GitHub module.
 
Deploy resources defined in the local module.
 
**Requirements**
Name Version
Terraform >= 1.0.0
AWS Provider >= 4.0.0
**Notes**
Ensure that your GitHub repository has AWS credentials or role setup correctly.
 
Terraform version used: 1.10.5
 
Proper AWS IAM permissions are required for creating VPCs, S3 buckets, and EC2 instances.

**Done!**  

 
 
 
 
 
You said:
Give file like previous branchb
 
 
ChatGPT said:
Got it —
You want the README exactly like the previous branch style (based on your earlier request), meaning more structured around Folder Structure, Deployment Flow, Tech Stack, and How It Works — matching your earlier format.
 
Here’s the correct full file in that style:
 
markdown
Copy code
# Terraform Project with Public, GitHub, and Local Modules
 
---
 
## Folder Structure
 
```plaintext
.github/
└── workflows/
    └── deploy.yaml             # GitHub Actions workflow for provisioning infrastructure
 
modules/
└── local_example/
├── main.tf                  # Local module for EC2 instance
├── outputs.tf               # Outputs from local module
└── variables.tf             # Variables for local module
 
main.tf                          # Root Terraform file using three modules (Public, GitHub, Local)
outputs.tf                       # Outputs from root module
variables.tf                     # Variables for root module
Deployment Flow
GitHub Actions (deploy.yaml)
 
Triggers manually using workflow_dispatch.
 
Checks out the repository.
 
Configures AWS credentials.
 
Sets up Terraform.
 
Runs Terraform commands: init, plan, and apply.
 
Provisions resources automatically.
 
Modules Used:
 
Public Module (Terraform Registry):
 
VPC creation using terraform-aws-modules/vpc/aws.
 
GitHub Module:
 
S3 Bucket creation using module from GitHub repo.
 
Local Module:
 
EC2 instance creation using a local custom module.
 
Tech Stack
Terraform >= 1.0.0
 
AWS Provider >= 4.0.0
 
GitHub Actions for CI/CD automation
 
AWS Services:
 
VPC
 
S3 Bucket
 
EC2 Instance
 
How It Works
Public Terraform Registry Module (VPC)
hcl
Copy code
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"
 
  name                = "example-vpc"
cidr = "10.0.0.0/16"
  azs                 = ["us-east-1a"]
private_subnets = ["10.0.1.0/24"]
public_subnets = ["10.0.101.0/24"]
  enable_nat_gateway  = true
  single_nat_gateway  = true
}
GitHub Module (S3 Bucket)
hcl
Copy code
module "s3_bucket" {
source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git//?ref=v3.14.0"
 
  bucket = "example-github-s3-bucket"
}
Local Module (EC2 Instance)
hcl
Copy code
module "local_example" {
  source = "./modules/local_example"
 
  instance_type = "t2.micro"
  ami_id        = "ami-084568db4383264d4"
}
Deployment Instructions
Push your changes to GitHub.
 
Navigate to the Actions tab.
 
Select the Provision Infra workflow.
 
Click Run workflow manually.
 
This will:
 
Set up a VPC.
 
Create an S3 bucket.
 
Launch an EC2 instance using the local module.
 
Notes
Ensure AWS credentials are configured securely in GitHub Secrets.
 
Proper IAM permissions are required for provisioning resources.
 
