# Create a elastic IP address for NIC1
resource "aws_eip" "eip-one" {
  network_interface         = aws_network_interface.NIC1.id
  associate_with_private_ip = "10.0.1.10"
  depends_on                = [var.IGW]
}

# Create a elastic IP address for NIC2
resource "aws_eip" "eip-two" {
  network_interface         = aws_network_interface.NIC2.id
  associate_with_private_ip = "10.0.2.10"
  depends_on                = [var.IGW]
}