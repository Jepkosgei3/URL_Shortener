variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "ami_id" {
  description = "Amazon Machine Image ID for the EC2 instance"
  type        = string
  default     = "ami-00c257e12d6828491" # Ubuntu AMI ID for us-west-2, replace with the latest for your region
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "keypair" #ensure the keypair name is correct
}
