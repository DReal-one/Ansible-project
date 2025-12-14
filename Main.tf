#----------------------------------------------------------------
# CONFIGURE AWS PROVIDER
#----------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

#----------------------------------------------------------------
# CREATE INVENTORY FILE
#----------------------------------------------------------------
resource "local_file" "ansible_inventory" {
  content = templatefile("template/hosts.tpl",
    {
      key_name = var.key_name,
      servers  = aws_instance.ansible_nodes.*.public_ip
    }
  )

  filename = "./ansible/hosts.cfg"
}

#----------------------------------------------------------------
# CREATE EC2 ANSIBLE CONTROLLER SERVER
#----------------------------------------------------------------
resource "aws_instance" "ansible_controller" {
  ami                         = var.amiid
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Ansible-Controller"
  }
  user_data  = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo apt install ansible python3 -y
              EOF
  depends_on = [aws_instance.ansible_nodes]
}

#----------------------------------------------------------------
# CREATE ANSIBLE NODES
#----------------------------------------------------------------
resource "aws_instance" "ansible_nodes" {
  count                       = var.severcount
  ami                         = var.amiid
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Ansible-Node-${count.index + 1}"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install python3 -y
              EOF



  #----------------------------------------------------------------
  # COPY FILES TO ANSIBLE CONTROLLER SERVER
  #----------------------------------------------------------------
  provisioner "file" {
    source      = "./ansible/hosts.cfg"
    destination = "/home/ubuntu/hosts.cfg"
  }

  provisioner "file" {
    source      = "./${var.key_name}.pem"
    destination = "/home/ubuntu/${var.key_name}.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/${var.key_name}.pem"
    ]
  }

  #----------------------------------------------------------------
  # SETUP SSH CONNECTION TO ANSIBLE CONTROLLER SERVER
  #----------------------------------------------------------------  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./${var.key_name}.pem")
    host        = self.public_ip
  }
}


