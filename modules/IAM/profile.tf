# Define IAM role that allows EC2 instances to communicate with CodeDeploy
resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-role-terraform"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}



# Attach IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "codedeploy_policy_attachment" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

# Define IAM instance profile
resource "aws_iam_instance_profile" "codedeploy_instance_profile" {
  name = "codedeploy-instance-profile"
  role = aws_iam_role.codedeploy_role.name
}