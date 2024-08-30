# Create EC2 Instances

resource "aws_instance" "app_server1" {
  ami                  = "ami-078701cc0905d44e4"
  instance_type        = "t2.micro"
  availability_zone    = "us-west-2a"
  key_name             = "Terraform-VM-Key" # Change this to your own key name (This is the key name you need to create in the aws console)
  iam_instance_profile = var.IAM_Profile
  

  network_interface {
    network_interface_id = aws_network_interface.NIC1.id
    device_index         = 0
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install ruby -y
              sudo yum install wget
              cd /home/ec2-user
              wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
              sudo chmod +x ./install
              sudo ./install auto
              cd ~
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF

  tags = {
    Name = "app-server-one"
  }
}

resource "aws_instance" "app_server2" {
  ami                  = "ami-078701cc0905d44e4"
  instance_type        = "t2.micro"
  availability_zone    = "us-west-2b"
  key_name             = "Terraform-VM-Key" # Change this to your own key name (This is the key name you need to create in the aws console)
  iam_instance_profile = var.IAM_Profile

  network_interface {
    network_interface_id = aws_network_interface.NIC2.id
    device_index         = 0
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install ruby -y
              sudo yum install wget
              cd /home/ec2-user
              wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
              sudo chmod +x ./install
              sudo ./install auto
              cd ~
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF

  tags = {
    Name = "app-server-two"
  }
}

# Create a Network Interface(s)

resource "aws_network_interface" "NIC1" {
  subnet_id       = var.aws_subnet_one
  private_ips     = ["10.0.1.10"]
  security_groups = [aws_security_group.instance-SG.id]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_network_interface" "NIC2" {
  subnet_id       = var.aws_subnet_two
  private_ips     = ["10.0.2.10"]
  security_groups = [aws_security_group.instance-SG.id]

  tags = {
    Name = "secondary_network_interface"
  }
}