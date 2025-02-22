terraform {
  backend "s3" {
    bucket  = "bucket_name"  # Replace with your bucket name
    key     = "terraform.tfstate"           # State file path in the bucket
    region  = "region"                   # AWS region
    encrypt = true                          # Enable encryption
  }
}

provider "aws" {
  region = var.aws_region
}

# aws_security_group
resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow SSH, HTTP, HTTPS, and all TCP traffic"

  # Allow SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the world (restrict in production)
  }

  # Allow HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all TCP traffic (ports 1-65535)
  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the world (restrict in production)
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "web_role" {
  name = "web-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "web_profile" {
  name = "web-instance-profile-ne"
  role = aws_iam_role.web_role.name
}

resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.web_profile.name
  user_data              = <<-EOF
                            #!/bin/bash
                            # Update and install Python and pip
                            sudo apt update -y
                            sudo apt install -y python3 
                          EOF

  tags = {
    Name = "Django-Web-Server"
  }
}
