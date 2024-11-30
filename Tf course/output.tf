# output "instance_ip" {
#   value = aws_instance.example.public_ip
# }
output "instance_public_ip" {
  value = module.ec2_instance.instance_public_ip
}

output "instance_private_ip" {
  value = module.ec2_instance.instance_private_ip
}
