# Task 2: Networking Resources

# Deploy EC2 Bastion Host / NAT Instance
resource "aws_instance" "nat_instance" {
  ami           = var.ec2_amazon_linux_ami
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name
  tags = {
    Name = "Bastion Host / NAT Instance for Kubernetes Infrastructure"
  }
  network_interface {
    network_interface_id = aws_network_interface.nat_interface.id
    device_index         = 0
    network_card_index   = 0
  }
  user_data = templatefile("bastion_host.sh", {})
}


# Task 3: k3s Setup

# Create a k3s Server instance in Private subnet #1
resource "aws_instance" "k3s_server" {
  ami                    = var.ec2_amazon_linux_ami
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.k3s_server_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  tags = {
    Name = "k3s Server Instance"
  }
  user_data = templatefile("k3s_server.sh", {
    token = var.token
  })
}

# Create a k3s Agent instance in Private subnet #2
resource "aws_instance" "k3s_agent" {
  ami                    = var.ec2_amazon_linux_ami
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.k3s_agent_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  tags = {
    Name = "K3s Agent Instance"
  }
  depends_on = [aws_instance.k3s_server]
  user_data = templatefile("k3s_agent.sh", {
    token       = var.token,
    server_addr = aws_instance.k3s_server.private_ip
  })
}