provider "aws" {
  region = var.region
}
 
resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
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
      "cd /home/ubuntu/network_infra && terraform init && terraform plan  && terraform apply -auto-approve"
    ]
  }
 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
    
  }
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "bastion-instance-profile-01"
  role = "dummy"
}
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg05"
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
