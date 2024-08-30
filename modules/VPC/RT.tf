# Create a Route Table

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "SumnerTech-RT-Terraform" # Change this to your own route table name
  }
}

# route table association for subnet 1
resource "aws_route_table_association" "RT-Association1" {
  subnet_id      = aws_subnet.subnet-one.id
  route_table_id = aws_route_table.RT.id
}

# route table association for subnet 2
resource "aws_route_table_association" "RT-Association2" {
  subnet_id      = aws_subnet.subnet-two.id
  route_table_id = aws_route_table.RT.id
}