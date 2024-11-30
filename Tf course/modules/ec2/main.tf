resource "aws_security_group" "allow_ssh_http" {
  name_prefix = "${var.instance_name}_sg"
  description = "Allow SSH and HTTP inbound traffic"

  # SSH Access (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  # HTTP Access (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }

     inline = [
    "sudo apt update -y",                           # Update the server
    "sudo apt install -y apache2",                   # Install Apache HTTP server (Ubuntu package)
    #"echo '<html><body><h1>Hello, World from Terraform!</h1></body></html>' | sudo tee /var/www/html/index.html",  # Create a simple HTML page
    "sudo systemctl start apache2",                  # Start Apache HTTP server
    "sudo systemctl enable apache2",                 # Enable Apache HTTP server to start on boot
    "sudo ufw allow 'Apache'  # Allow HTTP traffic through firewall"  # Open HTTP port in firewall (if UFW is enabled)
  ]
  }

  tags = {
    Name = var.instance_name
  }
}
