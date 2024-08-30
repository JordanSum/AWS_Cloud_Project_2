# Create a Subnet(s)

resource "aws_subnet" "subnet-one" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "production-subnet1"
  }
}

resource "aws_subnet" "subnet-two" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "production-subnet2"
  }
}