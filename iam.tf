# Create the Role
resource "aws_iam_role" "ec2_role" {
  name = "project1-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# Attach a Read-Only Policy
resource "aws_iam_role_policy_attachment" "s3_read" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Create the Instance Profile 
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "project1-ec2-profile"
  role = aws_iam_role.ec2_role.name
}