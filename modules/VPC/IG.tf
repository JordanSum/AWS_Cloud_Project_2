# Create an Internet Gateway

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "IGW" # Change this to your own Internet Gateway name
  }
}