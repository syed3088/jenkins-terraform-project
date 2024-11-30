variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instance"
  type        = string
}

variable "key_pair_name" {
  description = "The name of the existing key pair"
  type        = string
}

variable "allowed_cidr" {
  description = "The CIDR blocks allowed to access the instance"
  type        = list(string)
}

variable "private_key_path" {
  description = "Path to the private key file for SSH access"
  type        = string
}
