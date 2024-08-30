output "subnet_one" {
 value = aws_subnet.subnet-one.id
}

output "subnet_two" {
 value = aws_subnet.subnet-two.id
}

output "vpc_id_output" {
 value = aws_vpc.VPC.id
  
}

output "IGW" {
    value = aws_internet_gateway.IGW.id
  
}