variable "region1" {
  default = "us-east-1"
}

variable "region2" {
  default = "ap-south-1"
}

variable "ami_region1" {
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2 for us-east-1
}

variable "ami_region2" {
  default = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2 for ap-south-1
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Your EC2 key pair name"
  default     = "demo-keypair"
}
