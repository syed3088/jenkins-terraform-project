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
    "sudo apt update -y",                          # Update server
    "sudo apt install -y apache2",                  # Install Apache HTTP server
    # Create the HTML page with Cloud Coach branding and content
    "echo '<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"></head><body><header><h1>Welcome to Cloud Coach</h1><p>Your AWS and DevOps Experts</p></header><section class=\"services\"><h2>Our Services</h2><ul><li>AWS Training</li><li>DevOps Training</li><li>Cloud Infrastructure Consulting</li><li>Hands-on Workshops</li></ul></section><section class=\"about\"><h2>Why Choose Us?</h2><p>With experienced trainers and practical knowledge, we offer top-notch training for AWS, DevOps, and cloud infrastructure solutions. Join us to take your career to the next level!</p></section><footer><p>&copy; 2024 Cloud Coach</p></footer></body></html>' | sudo tee /var/www/html/index.html", 
    
    # Create a stylish CSS file with animations and hover effects
    "echo 'body { font-family: Arial, sans-serif; background-color: #f9f9f9; color: #333; margin: 0; padding: 0; } header { background-color: #3498db; color: white; text-align: center; padding: 30px; animation: fadeIn 2s ease-in; } header h1 { margin: 0; font-size: 48px; } header p { font-size: 18px; } section { padding: 20px; margin: 20px; } .services { background-color: #ecf0f1; border-radius: 8px; animation: slideIn 1.5s ease-out; } .services h2 { font-size: 32px; color: #2c3e50; } .services ul { list-style-type: none; padding: 0; } .services li { background-color: #ffffff; margin: 10px 0; padding: 15px; border-radius: 5px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); transition: transform 0.3s ease-in-out; } .services li:hover { transform: scale(1.05); } .about { background-color: #f4f4f4; border-radius: 8px; padding: 15px; animation: fadeIn 2s ease-in-out; } footer { text-align: center; padding: 10px; background-color: #3498db; color: white; position: fixed; width: 100%; bottom: 0; } @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } } @keyframes slideIn { from { transform: translateX(-100%); } to { transform: translateX(0); } }' | sudo tee /var/www/html/style.css",
    
    "sudo systemctl start apache2",                 # Start Apache HTTP server
    "sudo systemctl enable apache2",                # Enable Apache to start on boot
    "sudo systemctl restart apache2",               # Restart Apache HTTP server to apply changes
    "sudo ufw allow 'Apache' # Allow HTTP traffic through firewall"
  ]
}


  tags = {
    Name = var.instance_name
  }
}
