terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = file(var.user_data_path)
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
