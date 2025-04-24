resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
public_key = file("~/.ssh/id_rsa.pub") # Upload your public key to GitHub secrets if needed
}
 
resource "aws_instance" "vm" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  tags = {
    Name = "Terraform-EC2"
  }
}
