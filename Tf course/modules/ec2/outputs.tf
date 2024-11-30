output "instance_public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.example.public_ip
}

output "instance_private_ip" {
  description = "The private IP of the instance"
  value       = aws_instance.example.private_ip
}
