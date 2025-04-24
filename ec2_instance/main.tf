provider "aws" {
  region = var.region
}
 
resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  tags = {
    Name = "Terraform-Bastion"
  }
 
  provisioner "file" {
    source      = "../network_infra"
    destination = "/home/ubuntu/network_infra"
  }

  provisioner "file" {
    source      = "../modules"
    destination = "/home/ubuntu/modules"
  }
 
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y unzip",
      "curl -o terraform.zip https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip",
      "unzip terraform.zip",
      "sudo mv terraform /usr/local/bin/",
      "aws s3 cp s3://lavanya-bucket001/var.tfvars var.tfvars",
      "cd /home/ubuntu/network_infra && terraform init && terraform plan -var-file="var.tfvars"  && terraform apply -var-file="var.tfvars" -auto-approve 
    ]
  }
 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
    
  }
}
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # open for testing
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
