provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source           = "./modules/ec2"
  instance_name    = "MyEC2Instance"
  instance_type    = "t2.micro"
  ami_id           = "ami-0866a3c8686eaeeba"                                      # Replace with your AMI ID
  key_pair_name    = "terraform-kp"                                               # Your key pair name
  allowed_cidr     = ["0.0.0.0/0"]                                                # Open SSH access to everyone (adjust as necessary)
  private_key_path = private_key_path = file("Tf course/terraform-kp.pem") # Path to your private key
}
