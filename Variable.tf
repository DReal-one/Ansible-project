variable "vpc_id" {
  description = "VPC ID where resources will be created"
  default     = data.aws_vpc.default.id
}

variable "amiid" {
  description = "AMI ID for the EC2 instance"
  default = "ami-0ecb62995f68bb549"
}
variable "instance_type" {
  description = "Type of EC2 instance"
  default = "t3.micro"
}
variable "key_name" {
  description = "Name of the SSH key pair"
  default = "main"
}
variable "region" {
  description = "AWS region to deploy resources"
  default = "us-east-1"
}
variable "servercount" {
  description = "Number of servers to create"
  type        = number
  default     = 1
}

