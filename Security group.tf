#----------------------------------------------------------------
# FETCH YOUR CURRENT PUBLIC IP
#----------------------------------------------------------------
data "http" "myip" {
  url = "https://checkip.amazonaws.com/"
}

#----------------------------------------------------------------
# SECURITY GROUP TO ALLOW SSH
#----------------------------------------------------------------
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id # replace with your VPC ID variable or hardcode

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"] # Allow only your current IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }

}
