# Server 1 : 'Master - Server1' (with jenkins, Maven, Docker, Ansible, Trivy)
# Step -1 : Creting a security group for jenkins Server
# Description : Allow SSH, HTTP , HTTPS, 8080
resource "aws_security_group" "my-securit_group1"
 
 name : "my-security group1"
 Description: Allow SSH, HTTP, HTTPS, 8080 for jenkins Server

 # SSH Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
   from_port = 80
   to_port   = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# SSH Outbound Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# STEP2: CREATE AN JENKINS EC2 INSTANCE USING EXISTING PEM KEY
# Note: i. First create a pem-key manually from the AWS console
#      ii. Copy it in the same directory as your terraform code
resource "aws_instance" "my_ec2_instance1"{
  ami                    = "ami-0866a3c8686eaeeba"
  instance_type          = "t2.large"
  key_name               = "saikiran"
  vpc_security_group_ids = [aws_security_group.my_security_group1.id]
  

  # Consider EBS volume 30GB
  root_block_device {
    volume_size = 30    # Volume size 30 GB
    volume_type = "gp2" # General Purpose SSD
  }

  tags = {
    Name = "MASTER-SERVER"
  }
}

