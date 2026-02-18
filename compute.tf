data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  # PHASE 1: Placing it in the first PRIVATE subnet
  subnet_id = aws_subnet.private[0].id

  # PHASE 2: Attaching the "Least Privilege" Security Group
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  # PHASE 2: Attaching the IAM Instance Profile
  iam_instance_profile = aws_iam_instance_profile.web_instance_profile.name

  # PHASE 4: Injecting the Bash Script
  user_data = file("${path.module}/scripts/install_apache.sh")

  tags = {
    Name = "${var.project_name}-web-server"
  }
}