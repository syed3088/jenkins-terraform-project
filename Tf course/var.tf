# variable "instance_type" {
#   description = "The type of instance to create"
#   default     = "t2.micro"
# }

# variable "ami_id" {
#   description = "The AMI ID of instance to create"
#   default     = "ami-0866a3c8686eaeeba"
# }

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the instance"
  type        = string
}