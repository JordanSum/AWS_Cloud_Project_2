# Create a VPC

resource "aws_vpc" "VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "SumnerTech-VPC-Terraform" # Change this to your own VPC name
  }
}