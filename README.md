# Provision Infrastructure via Terraform and GitHub Actions
 
![Terraform Deployment](https://github.com/lavanya24072000/feature/terraform-S3-USER/actions/workflows/deploy.yaml/badge.svg)
 
## Overview

***** Provision Infrastructure via Terraform and GitHub Actions*****
- Overview
This project provisions an EC2 instance using Terraform.
 After the EC2 is created, it SSHs into the EC2 and provisions VPC, Subnets, IGW, and NAT Gateway inside the EC2 using Terraform again.
The full workflow is automated using GitHub Actions.
- Folder Structure

.
├── .github
│   └── workflows
│       └── deploy.yaml
│
├── ec2_instance
│   ├── backend.tf
│   ├── main.tf
│   ├── output.tf
│   └── variables.tf
│
├── modules
 
│
└── network_infra
    ├── backend.tf
    ├── main.tf
    ├── outputs.tf
    └── variables.tf
- Components
1. EC2 Instance Provisioning (ec2_instance/)
Creates a bastion EC2 instance.
Installs Terraform and Nginx inside the EC2.
Copies the network_infra/ and modules/ folders into EC2.
Initializes Terraform inside EC2 and applies network_infra to provision VPC and networking resources.

2. Network Infrastructure Provisioning (network_infra/)
Provisions:
VPC
Subnets
Internet Gateway
NAT Gateway
Route Tables
Uses Terraform backend configured with an S3 bucket (lavanya-bucket001).

3. GitHub Actions Workflow (.github/workflows/deploy.yaml)
Triggers manually (workflow_dispatch).
Configures AWS credentials.
Saves EC2 private key to connect via SSH.
Runs Terraform commands (init, plan, apply) to create EC2.
SSHs into EC2 to run Terraform again inside it.
Uploads logs as GitHub artifacts.

- How It Works
GitHub Actions creates an EC2 instance.
SSH into EC2 using private key.
Install Terraform inside EC2.
Copy Terraform modules and network_infra folder into EC2.
From EC2, run terraform init, terraform plan, and terraform apply for network setup.
- Prerequisites
Terraform >=1.6.6
AWS Account with required permissions.
- GitHub Secrets:
ROLE: IAM Role ARN to assume.
EC2_PRIVATE_KEY: Private key to SSH into EC2.

- S3 Backend Configuration
For EC2 Creation (ec2_instance/backend.tf)
hcl
Copy code
terraform {
  backend "s3" {
    bucket         = "lavanya-bucket901"
    key            = "terraform/state/network_infra.tfstate"
    region         = "us-east-1"
    use_lock_table = true
    encrypt        = true
  }
}
For Network Infra (network_infra/backend.tf)
hcl
Copy code
terraform {
  backend "s3" {
    bucket         = "lavanya-bucket001"
    key            = "terraform/state/network_infra.tfstate"
    region         = "us-east-1"
    use_lock_table = true
    encrypt        = true
  }
}
- How to Trigger
Go to GitHub Actions tab.
Select Provision Infra using Terraform via EC2.
Click Run Workflow manually.

- Outputs
EC2 Public IP
Logs uploaded as GitHub Artifacts.

- Notes
EC2 Security Group is open to SSH (22/tcp) and HTTP (80/tcp) for testing.
Replace hardcoded values (AMI, Key Pair) with variables in production.

Done!

...
 
