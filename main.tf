terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ---------------------
# Provider 1 (Region 1)
# ---------------------
provider "aws" {

  alias  = "region1"
  region = var.region1
}

# ---------------------
# Provider 2 (Region 2)
# ---------------------
provider "aws" {
  alias  = "region2"
  region = var.region2
}

# ---------------------
# Data Source to Get Default VPCs
# ---------------------
data "aws_vpc" "default_region1" {
  provider = aws.region1
  default  = true
}

data "aws_vpc" "default_region2" {
  provider = aws.region2
  default  = true
}

# ---------------------
# Module for Region 1
# ---------------------
module "ec2_region1" {
  source          = "./modules/ec2-instance"
  providers       = { aws = aws.region1 }
  ami_id          = var.ami_region1
  instance_type   = var.instance_type
  key_name        = var.key_name
  vpc_id          = data.aws_vpc.default_region1.id
  instance_name   = "nginx-region1"
  user_data_path  = "${path.module}/scripts/userdata.sh"
}

# ---------------------
# Module for Region 2
# ---------------------
module "ec2_region2" {
  source          = "./modules/ec2-instance"
  providers       = { aws = aws.region2 }
  ami_id          = var.ami_region2
  instance_type   = var.instance_type
  key_name        = var.key_name
  vpc_id          = data.aws_vpc.default_region2.id
  instance_name   = "nginx-region2"
  user_data_path  = "${path.module}/scripts/userdata.sh"
}
